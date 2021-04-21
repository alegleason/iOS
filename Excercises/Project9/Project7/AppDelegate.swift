//
//  AppDelegate.swift
//  Project7
//
//  Created by Alejandro Gleason on 20/03/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    /* We will to the following:
     1. Create a duplicate View Controller
     2. Wrap it inside Navigation Controller
     3. Use a new tab bar item to distinguish from the existing tab
     4. Add it to the list of visible tabs
     */
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // var window is the window where our app is running, which has a rootViewController and CAN BE a UITabBarController
        if let tabBarController = window?.rootViewController as? UITabBarController {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            // We will use the identifier we put from a beginning
            let vc = storyboard.instantiateViewController(withIdentifier: "NavController")
            // We will use tag 1 to re use the class
            vc.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 1)
            // To show is the navigation controller we append it to our viewControllers array of the tab bar controller
            tabBarController.viewControllers?.append(vc)
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


}

