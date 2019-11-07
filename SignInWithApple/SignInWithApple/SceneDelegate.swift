//
//  SceneDelegate.swift
//  SignInWithApple
//
//  Created by ICloud on 2019/10/10.
//  Copyright © 2019 ICloud. All rights reserved.
//

import UIKit
import BackgroundTasks
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
       
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
       
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        cancelAllPandingBGTask()
        scheduleAppRefresh()
        scheduleImageFetcher()
    }

}

//MARK:- BGTask Helper
extension SceneDelegate {
    
    func cancelAllPandingBGTask() {
        BGTaskScheduler.shared.cancelAllTaskRequests()
    }
    
    func scheduleImageFetcher() {
        let request = BGProcessingTaskRequest(identifier: "com.SO.imagefetcher")
        request.requiresNetworkConnectivity = false // Need to true if your task need to network process. Defaults to false.
        request.requiresExternalPower = true
        
        request.earliestBeginDate = Date(timeIntervalSinceNow: 1) // Featch Image Count after 1 minute.
        //Note :: EarliestBeginDate should not be set to too far into the future.
        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print("Could not schedule image featch: \(error)")
        }
    }
    
    func scheduleAppRefresh() {
        let request = BGAppRefreshTaskRequest(identifier: "com.SO.apprefresh")
        request.earliestBeginDate = Date(timeIntervalSinceNow: 2 * 60) // App Refresh after 2 minute.
        //Note :: EarliestBeginDate should not be set to too far into the future.
        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print("Could not schedule app refresh: \(error)")
        }
    }
    
    func handleAppRefreshTask(task: BGAppRefreshTask) {
        //Todo Work
        /*
         //AppRefresh Process
         */
        task.expirationHandler = {
            //This Block call by System
            //Canle your all tak's & queues
        }
        print("------loading----->")
        //
        task.setTaskCompleted(success: true)
    }
    
    func handleImageFetcherTask(task: BGProcessingTask) {
        scheduleImageFetcher() // Recall
        
         let queue = OperationQueue()
         queue.maxConcurrentOperationCount = 1

        
         task.expirationHandler = {
             queue.cancelAllOperations()
         }

         // サンプルの処理をキューに詰めます
         let array = [1, 2, 3, 4, 5]
         array.enumerated().forEach { arg in
             let (offset, value) = arg
             let operation = PrintOperation(id: value)
             if offset == array.count - 1 {
                 operation.completionBlock = {
                     // 最後の処理が完了したら、必ず完了したことを伝える必要があります
                     task.setTaskCompleted(success: operation.isFinished)
                 }
             }
             queue.addOperation(operation)
         }
        
    }
}

class PrintOperation: Operation {
    let id: Int

    init(id: Int) {
        self.id = id
    }

    override func main() {
        print("this operation id is \(self.id)")
    }
}
