//
//  AppDelegate.swift
//  SignInWithApple
//
//  Created by ICloud on 2019/10/10.
//  Copyright © 2019 ICloud. All rights reserved.
//

import UIKit
import BackgroundTasks
import AuthenticationServices
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            registerBackgroundTaks()
            registerLocalNotification()
        ///判断本地是否注销
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: "000770.fdf761f296e14fb2847175a22de491fc.0101") { (credentialState, error) in
            switch credentialState {
            case .authorized:
                // The Apple ID credential is valid.
                print("authorized")
                break
            case .revoked:
                // The Apple ID credential is revoked.
                print("revoked")
                break
            case .notFound:
                print("not found")
                // No credential was found, so show the sign-in UI.
//                DispatchQueue.main.async {
//                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                    guard let viewController = storyboard.instantiateViewController(withIdentifier: "loginViewController") as? LoginViewController
//                        else { return }
//                    viewController.modalPresentationStyle = .formSheet
//                    viewController.isModalInPresentation = true
//                    self.window?.rootViewController?.present(viewController, animated: true, completion: nil)
//                }
            default:
                break
            }
        }
           return true
       }
       
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    //MARK: Regiater BackGround Tasks
     private func registerBackgroundTaks() {
         
       let result = BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.SO.imagefetcher", using: nil) { task in
             self.scheduleLocalNotification()
//             self.handleImageFetcherTask(task: task as! BGProcessingTask)
         }
        
         BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.SO.apprefresh", using: nil) { task in
             self.scheduleLocalNotification()
//             self.handleAppRefreshTask(task: task as! BGAppRefreshTask)
         }
//        scheduleImageFetcher()
     }
}
//MARK:- Notification Helper

extension AppDelegate {
    
    func registerLocalNotification() {
        let notificationCenter = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        notificationCenter.requestAuthorization(options: options) {
            (didAllow, error) in
            if !didAllow {
                print("User has declined notifications")
            }
        }
    }
    
    func scheduleLocalNotification() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { (settings) in
            if settings.authorizationStatus == .authorized {
                self.fireNotification()
            }
        }
    }
    
    func fireNotification() {
        // Create Notification Content
        let notificationContent = UNMutableNotificationContent()
        
        // Configure Notification Content
        notificationContent.title = "Bg"
        notificationContent.body = "BG Notifications."
        
        // Add Trigger
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 1.0, repeats: false)
        
        // Create Notification Request
        let notificationRequest = UNNotificationRequest(identifier: "local_notification", content: notificationContent, trigger: notificationTrigger)
        
        // Add Request to User Notification Center
        UNUserNotificationCenter.current().add(notificationRequest) { (error) in
            if let error = error {
                print("Unable to Add Notification Request (\(error), \(error.localizedDescription))")
            }
        }
    }
    
}
