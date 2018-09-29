//
//  AppDelegate.swift
//  ShareSDKDemo
//
//  Created by ICloud on 2018/9/27.
//  Copyright © 2018年 ICloud. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        ShareSDK.registerActivePlatforms([
                SSDKPlatformType.typeSinaWeibo.rawValue,
                SSDKPlatformType.typeQQ.rawValue,
                SSDKPlatformType.typeWechat.rawValue
            ], onImport: { (platform: SSDKPlatformType) in
                switch platform
                {
                case SSDKPlatformType.typeSinaWeibo:
                    ShareSDKConnector.connectWeibo(WeiboSDK.classForCoder())
                case SSDKPlatformType.typeWechat:
                    ShareSDKConnector.connectWeChat(WXApi.classForCoder())
                case SSDKPlatformType.typeQQ:
                    ShareSDKConnector.connectQQ(QQApiInterface.classForCoder(), tencentOAuthClass: TencentOAuth.classForCoder())
                default:
                    break
                }
        }) { (platform: SSDKPlatformType, appInfo: NSMutableDictionary?) in
            switch platform
            {
            case SSDKPlatformType.typeSinaWeibo:
                //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                appInfo?.ssdkSetupSinaWeibo(byAppKey: "568898243",
                                            appSecret: "38a4f8204cc784f81f9f0daaf31e02e3",
                                            redirectUri: "http://www.sharesdk.cn",
                                            authType: SSDKAuthTypeBoth)
                
            case SSDKPlatformType.typeWechat:
                //设置微信应用信息
                appInfo?.ssdkSetupWeChat(byAppId: "wx3941f9f2f932baaa",
                                         appSecret: "9436b10ea068ae69cbe1b88605368321")
            case SSDKPlatformType.typeQQ:
                //设置QQ应用信息
                appInfo?.ssdkSetupQQ(byAppId: "1107742443",
                                     appKey: "IWKbO9EXm5Mo5fxa",
                                     authType: SSDKAuthTypeWeb)
            default:
                break
            }
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

