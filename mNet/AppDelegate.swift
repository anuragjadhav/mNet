//
//  AppDelegate.swift
//  mNet
//
//  Created by Anurag Jadhav on 12/19/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    var window: UIWindow?
    static let sharedInstance:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //MARK: Application Start Tasks
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        performAppStartTasks(application)
        return true
    }
    
    func performAppStartTasks(_ app:UIApplication) {
        
        checkLoginStatus()
        registerForPushNotifications(app)
    }
    
    func checkLoginStatus() {
        
        if User.isLoggedIn() {
            makeDashboardPageHome(false)
        }
            
        else {
            makeLoginPageHome(false)
        }
    }
    
    func makeLoginPageHome(_ animated:Bool) {
        
        if animated {
            
            UIView.transition(with: window!, duration: 0.4, options: .transitionFlipFromBottom, animations: {
                
                self.window?.rootViewController = UIStoryboard.login.instantiateInitialViewController()
                
            }, completion: nil)
        }
        else {
            
            window?.rootViewController = UIStoryboard.login.instantiateInitialViewController()
        }
        
        window?.makeKeyAndVisible()
    }
    
    func makeDashboardPageHome(_ animated:Bool) {
        
        if animated {
            
            UIView.transition(with: window!, duration: 0.4, options: .transitionFlipFromTop, animations: {
                
                self.window?.rootViewController = UIStoryboard.tabBar.instantiateInitialViewController()
                
            }, completion: nil)
        }
            
        else {
            
            window?.rootViewController = UIStoryboard.tabBar.instantiateInitialViewController()
        }
        window?.makeKeyAndVisible()
    }
    
    func logout() {
        
        makeLoginPageHome(true)
        User.logoutUser()
    }
    

    //MARK: Push Notifications
    func registerForPushNotifications(_ app:UIApplication) {
        
        //For iOS 10 and above
        if #available(iOS 10, *) {
            UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]){ (granted, error) in }
        }
        
        // iOS 9 support
        else {
            app.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
        }
        
        app.registerForRemoteNotifications()
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        let deviceTokenString:String = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        UserDefaults.standard.set(deviceTokenString, forKey: UserDefaultsKeys.deviceToken)
        UserDefaults.standard.synchronize()
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
        print("Failed To Register for remote notification - ",error.localizedDescription)
    }
    
    //MARK: Application Life Cycle
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

