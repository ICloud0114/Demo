//
//  NotificationViewController.swift
//  UserContentExtension
//
//  Created by ICloud on 2019/11/15.
//  Copyright © 2019 ICloud. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet weak var notificationImage: UIImageView!
    @IBOutlet weak var notificationTitle: UILabel!
    @IBOutlet weak var notificationBody: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
//        preferredContentSize = CGSize(width: self.view.frame.width, height: 500)
        
    }
    
    func didReceive(_ notification: UNNotification) {
        //原始信息print(notification.request.content.userInfo)
        notificationTitle.text = notification.request.content.title
        notificationBody.text = notification.request.content.body
        //访问附件中的内容
        if let attachment = notification.request.content.attachments.first {
            //安全访问沙盒资源
            if attachment.url.startAccessingSecurityScopedResource() {
                let tempImage = UIImage(contentsOfFile: attachment.url.path)
                //先将沙盒中的数据缓存起来，否则出现图片展示不完整情况
                let imgData = tempImage?.jpegData(compressionQuality: 1.0)
                let operateImage = UIImage(data: imgData!)
                self.notificationImage.image = operateImage
                attachment.url.stopAccessingSecurityScopedResource()
            }
        }
    }

    ///自定义通知点击事件
    func didReceive(_ response: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void) {
        //如果重写了此方法，需要对所有Action负责
//        必须对全部的action进行处理。必须设置completion
        let userInfo = response.notification.request.content.userInfo
          // Perform the task associated with the action.
          switch response.actionIdentifier {
          case "comfirm":
            completion(.doNotDismiss)
             break
          case "launch":
            //关闭通知界面，并且通知转发到app响应, AppDelegate 中UNUserNotificationCenterDelegate 获取通知信息
            completion(.dismissAndForwardAction)
          case "close":
            //关闭通知界面，并且内容扩展将处理该操作
            completion(.dismiss)
          case "feedback":
//            NSString* userSayStr = [(UNTextInputNotificationResponse *)response userText];
            let input = (response as! UNTextInputNotificationResponse).userText
            completion(.dismissAndForwardAction)
            break
          default:
             break
          }
        completion(.dismiss)
    }

}
