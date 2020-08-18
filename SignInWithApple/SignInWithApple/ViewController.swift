//
//  ViewController.swift
//  SignInWithApple
//
//  Created by ICloud on 2019/10/10.
//  Copyright © 2019 ICloud. All rights reserved.
//

import UIKit
//AuthenticationServices
import AuthenticationServices
import NetworkExtension
import CoreLocation
class ViewController: UIViewController {

    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let appleIDButton = ASAuthorizationAppleIDButton(type: .default, style: ASAuthorizationAppleIDButton.Style.white)
        appleIDButton.frame = CGRect(x: 100, y: 100, width: 130, height: 30)
        appleIDButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
        self.view.addSubview(appleIDButton)
//        hotspotConfiguration()
        if CLLocationManager.authorizationStatus() == .notDetermined{
            manager.requestWhenInUseAuthorization()
        }

        scanWifiList()
        print(UserManager.manager().isLogin)
        print(UserManager.manager().userName)
        UserManager.manager().userName = "Lily"
        print(UserManager.manager().userName)
        handleAuthorizationAppleIDButtonPress()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        performExistingAccountSetupFlows()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func performExistingAccountSetupFlows() {
        // Prepare requests for both Apple ID and password providers.
//        let requests = [ASAuthorizationAppleIDProvider().createRequest(),
//                        ASAuthorizationPasswordProvider().createRequest()]
//
//        // Create an authorization controller with the given requests.
//        let authorizationController = ASAuthorizationController(authorizationRequests: requests)
//        authorizationController.delegate = self
//        authorizationController.presentationContextProvider = self
//        authorizationController.performRequests()
    }
    
    @objc func handleAuthorizationAppleIDButtonPress(){
//        let appleIDProvider = ASAuthorizationAppleIDProvider()
//        // 创建新的AppleID 授权请求
//        let appleIDRequest = appleIDProvider.createRequest()
//        // 在用户授权期间请求的联系信息
//        appleIDRequest.requestedScopes = [.fullName, .email]
//        // 由ASAuthorizationAppleIDProvider创建的授权请求 管理授权请求的控制器
//        let authorizationController = ASAuthorizationController(authorizationRequests: [appleIDRequest])
//        // 设置授权控制器通知授权请求的成功与失败的代理
//        authorizationController.delegate = self
//        // 设置提供 展示上下文的代理，在这个上下文中 系统可以展示授权界面给用户
//        authorizationController.presentationContextProvider = self
//        // 在控制器初始化期间启动授权流
//        authorizationController.performRequests()
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    @IBAction func SignInAction(_ sender: Any) {
        handleAuthorizationAppleIDButtonPress()
//        let store = StoreViewController(url: nil)
//        self.navigationController?.pushViewController(store, animated: true)
    }
    
    private func hotspotConfiguration(){
        //这种方法可以连接特定的Wi-Fi
        let hotspotConfig = NEHotspotConfiguration(ssid: "SoftwareGroup_ios", passphrase: "software_ios", isWEP: false)
        NEHotspotConfigurationManager.shared.apply(hotspotConfig) { (error) in
            guard let err = error as NSError? else{
                NSLog("加入失败")
                return
            }
            if err.code != 13 && err.code != 7{
                NSLog("加入失败")
            }else if err.code == 7{
                NSLog("已取消")
            }else{
                NSLog("已连接")
            }
        }
        NEHotspotConfigurationManager.shared.getConfiguredSSIDs { (list) in
            for wifi in list{
                print("----> " + wifi)
            }
        }
    }
    
    private func scanWifiList(){
//        let targetAnnotation: String = "Acme Wireless"
//
//        let options: [String: NSObject] = [
//          kNEHotspotHelperOptionDisplayName: targetAnnotation as NSString
//        ]
        
        let concurrentQueue = DispatchQueue(label: "queuename", attributes: .concurrent)
        let result = NEHotspotHelper.register(options: nil, queue: concurrentQueue) { (cmd) in
            if cmd.commandType == .filterScanList{
                for network in cmd.networkList!{
                    print(network.ssid)
                }
            }
        }
        print("result--->\(result)")
    }
}

extension ViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding{
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        print("--->完成授权")
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            print("uid-->", userIdentifier)
            print("code-->", String(data: appleIDCredential.authorizationCode!, encoding: .utf8)!)
            print("idToken-->", String(data: appleIDCredential.identityToken!, encoding: .utf8)!)
            
        } else if let passwordCredential = authorization.credential as? ASPasswordCredential {
            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("--->授权出错")
        guard let err = error as? ASAuthorizationError else {
            return
        }
        switch err.code {
        case .canceled:
            print("--->授权取消")
        case .failed:
            print("--->授权失败")
        case .invalidResponse:
            print("--->授权请求响应无效")
        case .notHandled:
            print("--->未能处理授权请求")
        case .unknown:
            print("--->授权请求失败未知原因")
        default:
            break
        }
        print(error.localizedDescription)
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        print("------")
        return self.view.window!
    }
    
    
}

