/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Main application delegate.
*/

import UIKit
import AuthenticationServices

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        addNotification()
        ///判断本地是否注销
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: KeychainItem.currentUserIdentifier) { (credentialState, error) in
            switch credentialState {
            case .authorized:
                // The Apple ID credential is valid.
                break
            case .notFound, .revoked:
                // No credential was found, so show the sign-in UI.
                KeychainItem.deleteUserIdentifierFromKeychain()
                DispatchQueue.main.async {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    guard let viewController = storyboard.instantiateViewController(withIdentifier: "loginViewController") as? LoginViewController
                        else { return }
                    viewController.modalPresentationStyle = .formSheet
                    viewController.isModalInPresentation = true
                    self.window?.rootViewController?.present(viewController, animated: true, completion: nil)
                }
            default:
                break
            }
        }
        
        return true
    }
    func addNotification(){
        let center = NotificationCenter.default
        let name = ASAuthorizationAppleIDProvider.credentialRevokedNotification
        let observer = center.addObserver(forName: name, object: nil, queue: nil) { (notification) in
        // Sign the user out, optionally guide them to sign in again
            
            print("------被移除--")
        }
        
    }
}
