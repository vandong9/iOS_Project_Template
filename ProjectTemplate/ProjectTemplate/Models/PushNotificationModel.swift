//
//  PushNotificationModel.swift
//  ProjectTemplate
//
//  Created by dongha on 19/04/2021.
//

import Foundation

// TODO: update this model upon the project defined

struct PushNotificationModel {
    enum NotificationType {
        case type1
        case type2
        case unknown
    }

    var type: String = ""
    var metadata: [String:Any] = [:]
    
    var notificationType: NotificationType {
        switch type {
        case "_": return .type1
        default: return .unknown
            
        }
    }
}
