//
//  NotificationService.swift
//  UserServiceExtension
//
//  Created by ICloud on 2019/11/18.
//  Copyright © 2019 ICloud. All rights reserved.
//

import UserNotifications
import UIKit
class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        if let bestAttemptContent = bestAttemptContent {
            // Modify the notification content here...
            bestAttemptContent.title = "\(bestAttemptContent.title)哈哈哈[modified]"
            bestAttemptContent.body = "啦啦啦啦啦啦啦\n 哈哈哈哈哈 \n 咯咯咯"
            bestAttemptContent.subtitle = "副标题"
//            bestAttemptContent.categoryIdentifier = "category2"
        }
//        let url = URL(string: "http://img1.gtimg.com/sports/pics/hv1/194/44/2136/138904814.jpg")
//        let config = URLSessionConfiguration.default
//        let session = URLSession(configuration: config)
//       let task = session.dataTask(with: url!) { (data, response, error) in
//            if (error == nil){
//                let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first! + "/image.jpg"
//                let image = UIImage(data: data!)
//                do {
//                     try image?.jpegData(compressionQuality: 1)?.write(to: URL(fileURLWithPath: path), options: .atomicWrite)
//                    let attachment = try UNNotificationAttachment(identifier: "attach1", url: URL(fileURLWithPath: path), options: nil)
//                    self.bestAttemptContent?.attachments = [attachment]
//                    self.contentHandler!(self.bestAttemptContent!)
//                } catch {
//                    self.bestAttemptContent!.body = error.localizedDescription
//                }
//                contentHandler(self.bestAttemptContent!)
//            }
//        }
//        task.resume()
        //有附件的情况下
        let apsDic = request.content.userInfo["aps"] as! [String: Any]

        guard let attachUrl = apsDic["image"] as? String else {
            self.contentHandler!(bestAttemptContent!)
            return
        }
        //下载图片到本地，或者使用 Data(contentsOf: URL) 获取附件数据
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: URL(string: attachUrl)!) { (data, response, error) in
             if (error == nil){
                 let image = UIImage(data: data!)
                 do {
                    //存入本地沙盒中
                    let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first! + "/image.jpeg"
                    let url = URL(fileURLWithPath: path)
                    try image?.jpegData(compressionQuality: 1)?.write(to: url, options: .atomicWrite)
                    let attch = try UNNotificationAttachment(identifier: "image", url: url, options: nil)
                    self.bestAttemptContent?.attachments = [attch]
                 } catch let e as NSError{
                    self.bestAttemptContent?.body = e.localizedDescription
                 }
                self.contentHandler!(self.bestAttemptContent!)
             }
            
         }
        task.resume()
//        let picUrlString = apsDic["image"] as! String
//        let picPath = NSHomeDirectory().appending("/Documents").appending("/notice_media.png")
//        // 下载图片到本地
//        let urlSession = URLSession.shared
//        let downloadTask = urlSession.downloadTask(with: URL(string: picUrlString )!, completionHandler: { (location, response, error) in
//            if (error != nil) {
//                self.bestAttemptContent!.body = error.debugDescription
//                contentHandler(self.bestAttemptContent!)
//            } else {
//                // 图片存储到指定picPath位置
//                let fm = FileManager.default
//                do {
//                   try fm.moveItem(atPath: location!.path, toPath: picPath)
//                } catch let error as NSError {
//                    self.bestAttemptContent!.body = error.localizedDescription
//                    contentHandler(self.bestAttemptContent!)
//                }
//                // 创建通知附件
//                do {
//                    let attachment: UNNotificationAttachment
//                    try attachment = UNNotificationAttachment(identifier: "pic", url: URL(fileURLWithPath: picPath), options: nil)
//                    self.bestAttemptContent!.attachments = [attachment]
//                } catch let error as NSError {
//                    self.bestAttemptContent!.body = error.localizedDescription
//                }
//            }
//            contentHandler(self.bestAttemptContent!)
//        })
//        downloadTask.resume()
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
        
    }

}
