//
//  ViewController.swift
//  UserNotificationDemo
//
//  Created by ICloud on 2019/11/12.
//  Copyright © 2019 ICloud. All rights reserved.
//

import UIKit
import UserNotifications
import CoreLocation
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        checkNotificationAuthorizationStatus()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
//        let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first! + "/image.jpg"
//
//        do {
//            let data = try Data(contentsOf:URL(string: "http://img1.gtimg.com/sports/pics/hv1/194/44/2136/138904814.jpg")!)
//            let image = UIImage(data: data)
//            let url = URL(fileURLWithPath: path)
//            print(url)
//            try image?.jpegData(compressionQuality: 1)?.write(to: url, options: .atomicWrite)
//            
//            print(path)
////            let url = URL(string: "file://var/mobile/Containers/Data/PluginKitPlugin/4B79018A-4F2E-4085-91AA-B7460F149101/Library/image.jpg")!
//             let attch = try UNNotificationAttachment(identifier: "image", url: url, options: nil)
//            print(attch)
//            
//        } catch let err as NSError{
//            print("----不好啦！")
//            print(err)
//            
//        }
    }

    @IBAction func showStyle1(_ sender: Any) {
        let content = UNMutableNotificationContent()
            content.title = "小汪打扫完毕了"
            content.body = "扫了好多地方了"
            let url = Bundle.main.url(forResource: "hututu", withExtension: "png")
            do {
               let attch = try UNNotificationAttachment(identifier: "image", url: url!, options: nil)
                content.attachments.append(attch)
            } catch  {
            }
            content.categoryIdentifier = "category1"
        sendNotification(trigger: addTimeIntervalNotification(), context: content, identifier: "style1")
        
    }
    
    @IBAction func showStyle2(_ sender: Any) {
        let content = UNMutableNotificationContent()
            content.title = "样式2"
            content.body = "描述"
            content.categoryIdentifier = "category2"
        sendNotification(trigger: addTimeIntervalNotification(), context: content, identifier: "style2")
    }
    
    ///判断通知开关权限是否开启
    private func checkNotificationAuthorizationStatus(){
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            switch settings.authorizationStatus{
                case .authorized:
                    print("通知已授权")
                case .denied:
                    print("通知关闭")
                    let alert = UIAlertController(title: "开启通知", message: "通知未开启，接收不了消息推送", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "去开启", style: .default, handler: { (action) in
                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                    }))
                    self.present(alert, animated: true, completion: nil)
                case .notDetermined:
                    print("通知未确认")
                case .provisional:
                    print("临时通知")
                default:
                    break
            }
        }
    }
}

extension ViewController{
    //2min后提醒
    func addTimeIntervalNotification() -> UNNotificationTrigger{
        let trigger1 = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
        return trigger1
    }
    
    func addCalendarNotification() -> UNNotificationTrigger{
        //每周日早上 8：00 提醒
        var components = DateComponents()
        components.weekday = 1
        components.hour = 8
        return UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        
        
        //NSDateComponets的注意点，有了时间并不能得到weekday
//        var dateComponents = DateComponents()
//        dateComponents.day = 13;
//        dateComponents.month = 11;
//        dateComponents.year = 2019;
//        //输出结果是NSDateComponentUndefined = NSIntegerMax
//        print(dateComponents.weekday)
//        //根据calendar计算出当天是周几
//        let gregorianCalendar = NSCalendar(calendarIdentifier: .gregorian)
//
//        let date = gregorianCalendar?.date(from: dateComponents)
//        let weekday = gregorianCalendar?.component(.weekday, from: date!)
//
//        print("\(weekday)")
//
//        dateComponents.weekday = weekday;
//        print(dateComponents)
//        let trigger3 = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
    }
    
    func addLocationNotification() -> UNNotificationTrigger{
        let center = CLLocationCoordinate2DMake(37.335400, -122.009201)
        let region = CLCircularRegion(center: center, radius: 2000.0, identifier: "HeadQuarters")

        region.notifyOnEntry = true
        region.notifyOnExit = false
        
        return UNLocationNotificationTrigger(region: region, repeats: true)
    
    }
    
    func addNotification(){
//        sendNotification(trigger: addTimeIntervalNotification(), context: createNotificationContext(), identifier: "timeInterval")
//        sendNotification(trigger: addCalendarNotification(), context: createNotificationContext(), identifier: "Calendar")
    }
    
    func createNotificationContext() -> UNNotificationContent{
        let content = UNMutableNotificationContent()
        content.title = "通知"
//        content.subtitle = "副标题"
        content.body = "------描述"
//        content.categoryIdentifier = "category2"
//        content.categoryIdentifier = "category1"
        
//        let url = Bundle.main.url(forResource: "hu", withExtension: "jpeg")
//        let url2 = Bundle.main.url(forResource: "record", withExtension: "mp3")
//        do {
//           let attch = try UNNotificationAttachment(identifier: "image", url: url!, options: nil)
//            content.attachments.append(attch)
//        } catch  {
//        }
//        do {
//           let attch = try UNNotificationAttachment(identifier: "music", url: url2!, options: nil)
//            content.attachments.append(attch)
//        } catch  {
//        }
        return content
    }
    
    func sendNotification(trigger: UNNotificationTrigger, context: UNNotificationContent, identifier: String){
        
        let request = UNNotificationRequest(identifier: identifier, content: context, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error) in
            
        }
    }
}

extension ViewController{
    
}
