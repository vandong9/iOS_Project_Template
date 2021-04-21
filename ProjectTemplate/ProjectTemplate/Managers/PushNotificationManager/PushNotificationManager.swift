//
//  PushNotificationManager.swift
//  ProjectTemplate
//
//  Created by dongha on 19/04/2021.
//

import Foundation
import RxSwift
import NotificationBannerSwift

protocol IPushNotificationManagerRepository {
    func updateDeviceToken(deviceToken: String) -> Observable<Void>
    
}

class PushNotificationManager {
    // MARK: - Properties
    static let shared = PushNotificationManager()
    var repository: IPushNotificationManagerRepository
    private let disposeBag = DisposeBag()
    private var retriedSendToken = 0
    private(set) var deviceToken: String?
    
    lazy var type1UseCase: Type1UseCase = Type1UseCase()
    
    // MARK: - LifeCycle
    init(repository: IPushNotificationManagerRepository =  DefaultPushNotificationManagerRepository()) {
        self.repository = repository
    }
    
    // MARK: - Public Functions
    func setDeviceToken(_ deviceToken: String) {
        self.deviceToken = deviceToken
    }
    
    func postDeviceToken() {
        guard let deviceToken = deviceToken else { return }
        repository.updateDeviceToken(deviceToken: deviceToken).subscribe(onNext:{ [weak self] in
            self?.retriedSendToken = 0
        }, onError: { [weak self] _ in
            guard let self = self else { return }
            self.retriedSendToken += 1
            if self.retriedSendToken < 3 {
                self.postDeviceToken()
            } else {
                self.retriedSendToken = 0
            }
        }).disposed(by: disposeBag)
    }
    
    func handleReceivePushNotification(aps: [String: Any], isForgroundMode: Bool) {
        appLog.debug("Receive Notificaiton:")
        appLog.debug(aps)
        
        // Check login to show notification
//        guard AppDataManager.shared.currentToken != nil else { return }
        guard let metadata = aps["metadata"] as? [String: Any] else { return }

        var title: String? = ""
        var body: String? = ""
        if let alertDict = aps["alert"] as? [String: Any] {
            title = alertDict["title"] as? String
            body = alertDict["body"] as? String
        }
        
        var action: (()->Void)?
        let pushNotificationModel = PushNotificationModel(type: metadata["type"] as? String ?? "", metadata: metadata["data"] as? [String: Any] ?? [:])
        
        switch pushNotificationModel.notificationType{
        case .type1:
            action = { [weak self] in
                self?.type1UseCase.hanldePushNotificationTypy1()
            }
        default: break
            
        }
        
        // Call action or show banner which user can touch to launch action
        _ = isForgroundMode == false ? action?() : showNotificationBannerWithAction(title: title, body: body, action: action)
    }
    
    func showNotificationBannerWithAction(title: String?, body: String?, action: (()->Void)?) {
        let banner = GrowingNotificationBanner(title: title, subtitle: body, style: .success)        
        banner.show(bannerPosition: .top)
        banner.onTap = action
    }
}
