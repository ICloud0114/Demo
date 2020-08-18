/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Login view controller.
*/

import UIKit
import AuthenticationServices

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginProviderStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProviderLoginView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        performExistingAccountSetupFlows()
    }
    
    func setupProviderLoginView() {
        let authorizationButton = ASAuthorizationAppleIDButton()
        authorizationButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
        self.loginProviderStackView.addArrangedSubview(authorizationButton)
    }
    
    /// Prompts the user if an existing iCloud Keychain credential or Apple ID credential is found.
    func performExistingAccountSetupFlows() {
        // Prepare requests for both Apple ID and password providers.
        ///当用户确认过的就会弹出来
//        读取 Keychain 中保存的密码，苹果提供了与授权登录类似的 API
        let requests = [ASAuthorizationAppleIDProvider().createRequest(),
                        ASAuthorizationPasswordProvider().createRequest()]
        // Create an authorization controller with the given requests.
        let authorizationController = ASAuthorizationController(authorizationRequests: requests)
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    @objc
    func handleAuthorizationAppleIDButtonPress() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let passwordRequest = ASAuthorizationPasswordProvider().createRequest()
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request, passwordRequest])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            
            let userIdentifier = appleIDCredential.user
            ///当用户认证过后，第二次就不会获取到fullName、email信息了
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            let identityToken = appleIDCredential.identityToken?.base64EncodedString()
            print(identityToken)
            let code = appleIDCredential.authorizationCode?.base64EncodedString()
            print(code)
            
            guard let _ = identityToken else { return }
                        
//            let token = String(data: identityToken!, encoding: .utf8)
//            let arr = token?.components(separatedBy: ".")
//            let header = arr?[0]
//            let payload = arr?[1]
            
//            let headerData = Data(base64Encoded: header!, options: .ignoreUnknownCharacters)//NSData(base64Encoded: header!, options: .ignoreUnknownCharacters)
//            let decodeHeader = String(data: (headerData! as Data), encoding: .utf8)

//            let payloadData = NSData(base64Encoded: payload!, options: .ignoreUnknownCharacters)//NSData(base64Encoded: payload!)
//            let decodePayload = String(data: (payloadData! as Data), encoding: .utf8)
            
//            print("Header---" + decodeHeader!)
//            print("payload---" + decodePayload!)
            // Create an account in your system.
            // For the purpose of this demo app, store the userIdentifier in the keychain.
            do {
                try KeychainItem(service: "com.example.apple-samplecode.juice", account: "userIdentifier").saveItem(userIdentifier)
            } catch {
                print("Unable to save userIdentifier to keychain.")
            }
            
            // For the purpose of this demo app, show the Apple ID credential information in the ResultViewController.
            if let viewController = self.presentingViewController as? ResultViewController {
                DispatchQueue.main.async {
                    viewController.userIdentifierLabel.text = userIdentifier
                    if let givenName = fullName?.givenName {
                        viewController.givenNameLabel.text = givenName
                    }
                    if let familyName = fullName?.familyName {
                        viewController.familyNameLabel.text = familyName
                    }
                    if let email = email {
                        viewController.emailLabel.text = email
                    }
                    self.dismiss(animated: true, completion: nil)
                }
            }
        } else if let passwordCredential = authorization.credential as? ASPasswordCredential {
            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password
            
            // For the purpose of this demo app, show the password credential as an alert.
            DispatchQueue.main.async {
                let message = "The app has received your selected credential from the keychain. \n\n Username: \(username)\n Password: \(password)"
                let alertController = UIAlertController(title: "Keychain Credential Received",
                                                        message: message,
                                                        preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
