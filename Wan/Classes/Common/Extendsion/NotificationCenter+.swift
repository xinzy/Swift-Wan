//
//  NotificationCenter+.swift
//  Wan
//
//  Created by Yang on 2020/5/1.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import Foundation

extension NotificationCenter {
    
    func post(name notificationName: String) {
        post(Notification(name: Notification.Name(rawValue: notificationName)))
    }
    
    func post(name notificationName: String, object: Any? = nil, userInfo: [AnyHashable : Any]? = nil) {
        post(Notification(name: Notification.Name(rawValue: notificationName), object: object, userInfo: userInfo))
    }
}
