//
//  AlamofireAPIRequest.swift
//  ProjectTemplate
//
//  Created by dongha on 28/04/2021.
//

import Foundation
import Alamofire

class AlamofireAPIRequest: APIProtocol {
    private let sessionManager: Alamofire.Session
    fileprivate let queueDataCenter: DispatchQueue
    fileprivate struct QueueIdentity {
        let label: String
    }
    
    fileprivate let queueKey: DispatchSpecificKey<QueueIdentity>

    public convenience init(label: String) {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 60

        self.init(configuration: configuration, label: label)
    }
    
    public init(configuration: URLSessionConfiguration, label: String) {
        self.queueDataCenter = DispatchQueue(label: label)
        self.sessionManager = Alamofire.Session(configuration: configuration)
        self.queueKey = DispatchSpecificKey<QueueIdentity>()
    }

    public static var sharedInstance: AlamofireAPIRequest = {
        let sharedInstance = AlamofireAPIRequest(label: "com.mercury.SafeSyncQueue")
        return sharedInstance
    }()
    
    fileprivate var currentQueueIdentity: QueueIdentity? {
        return DispatchQueue.getSpecific(key: queueKey)
    }
    
    func sync(execute: ()->()) {
        if currentQueueIdentity?.label == queueDataCenter.label {
            execute()
        } else {
            queueDataCenter.sync(execute: execute)
        }
    }

    func asyncMainQueue(_ callback: @escaping () -> Void) {
        DispatchQueue.main.async {[weak self]  () -> Void in guard self != nil else {return }
            callback()
        }
    }
    
    public func stopAllSessions() {
        sessionManager.session.getAllTasks { tasks in
            tasks.forEach { $0.cancel() }
        }
    }
    
    
    func request(path: String, method: RequestMethod, headers: [String : String], parameters: [String : Any], completionBlock: (Result<Any, Error>) -> Void) {
        sessionManager.request(path, method: method.alamofireMethod, parameters: parameters, encoding: JSONEncoding.default, headers:  HTTPHeaders(headers))
            .responseJSON {[weak self] (response) in guard let strongSelf = self else {return }
                let resultData = response.result
//                let appResult = strongSelf.appResultWithAlamofireResult(result: resultData)
//                completionBlock(appResult)
        }

    }
    
    
}

extension RequestMethod {
    var alamofireMethod: HTTPMethod {
        switch self {
        case .get: return .get
        case .post: return .post
        case .put: return .put
        case .patch: return .patch
        case .delete: return .delete
        default: return .options            
        }
    }
}
