//
//  PushNotificationRepository.swift
//  ProjectTemplate
//
//  Created by dongha on 19/04/2021.
//

import Foundation
import RxSwift

class DefaultPushNotificationManagerRepository: IPushNotificationManagerRepository {
    func updateDeviceToken(deviceToken: String) -> Observable<Void> {
        return Observable.create { obsever in
            // TODO: post device-token to server
            DispatchQueue.main.async {
                obsever.onNext(Void())
                obsever.onCompleted()
            }
            return Disposables.create()
        }
    }
}
