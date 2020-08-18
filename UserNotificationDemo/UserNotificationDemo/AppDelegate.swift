//
//  AppDelegate.swift
//  UserNotificationDemo
//
//  Created by ICloud on 2019/11/12.
//  Copyright © 2019 ICloud. All rights reserved.
//

import UIKit
import UserNotifications
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        notificationAuthorizating()
        registerNotification(application)
        setCategoryNotification()
        return true
    }
    
    
    private func notificationAuthorizating(){
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization(options: [.badge, .sound, .alert], completionHandler: { (granted, error) in
            if error == nil {
            }
        })
    }
    
    private func registerNotification(_ application: UIApplication){
//        if !application.isRegisteredForRemoteNotifications{
            application.registerForRemoteNotifications()
//        }
    }
    
    private func setCategoryNotification(){
        
        //此操作需要用户解锁
        let action1 = UNNotificationAction(identifier: "comfirm", title: "确认", options: .authenticationRequired)
        //启动应用
        let action2 = UNNotificationAction(identifier: "launch", title: "启动", options: .foreground)
        //关闭 红色
        let action3 = UNNotificationAction(identifier: "close", title: "关闭", options: .destructive)
        
        let action5 = UNTextInputNotificationAction(identifier: "feedback", title: "", options: .foreground, textInputButtonTitle: "回复", textInputPlaceholder: "请输入回复内容")
        
        var category1 = UNNotificationCategory(identifier: "category1", actions: [action1, action2, action3], intentIdentifiers: [], options: .customDismissAction)
        
        var category2 = UNNotificationCategory(identifier: "category2", actions: [action5], intentIdentifiers: [], options: .customDismissAction)
        
        if #available(iOS 11.0, *) {
            category1 = UNNotificationCategory(identifier: "category1", actions: [action5], intentIdentifiers: [], hiddenPreviewsBodyPlaceholder: "", options: .customDismissAction)
            category2 = UNNotificationCategory(identifier: "category2", actions: [action5], intentIdentifiers: [], hiddenPreviewsBodyPlaceholder: "", options: .customDismissAction)

        }
        
        if #available(iOS 12.0, *) {
            category1 = UNNotificationCategory(identifier: "category1", actions: [action1, action2, action3], intentIdentifiers: [], hiddenPreviewsBodyPlaceholder: "", categorySummaryFormat: "", options: .customDismissAction)
            category2 = UNNotificationCategory(identifier: "category2", actions: [action5], intentIdentifiers: [], hiddenPreviewsBodyPlaceholder: "", categorySummaryFormat: "", options: .customDismissAction)
        }
        
        UNUserNotificationCenter.current().setNotificationCategories([category1, category2])
    }
    
    ///获取注册通知的Token
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("deviceToken:%@",deviceToken);
        let str = deviceToken.enumerated().map { (index, value) -> NSString in
            return NSString(format: "%02x", (value & 0xff))
        }.reduce("") { (result, next) -> String in
            return result + String(next)
        }
        print("deviceTokenStr:%@",str)
    }
    
}
extension AppDelegate: UNUserNotificationCenterDelegate{
    ///通知出来时
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let content = notification.request.content.userInfo
        completionHandler([.alert, .sound])
    }
    ///接收点击通知事件
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let context = response.notification.request.content
        
        guard let res = response as? UNTextInputNotificationResponse else {
            return
        }
        print(res.userText)
        
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) {
        
    }
    
}
