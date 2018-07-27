//
//  AppDelegate.swift
//  Modig
//
//  Created by Harutyun Arakelyan on 5/11/18.
//  Copyright © 2018 iOS_Gyumri. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        goToInitialVC()
        
        UINavigationBar.appearance().barTintColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        UINavigationBar.appearance().tintColor = .white
        
        return true
    }
    
    func goToInitialVC() {
        
        let st = UIStoryboard(name: "Main", bundle: nil)
        
        if(UserDefaults.standard.bool(forKey: "notFirstInApp")){
            let lVC = st.instantiateViewController(withIdentifier: "LocationViewControllerID") as! LocationViewController
            let navigationController = UINavigationController(rootViewController: lVC)
            window?.rootViewController = navigationController
        } else {
            let vc = st.instantiateViewController(withIdentifier: "WelcomeViewControllerID") as! WelcomeViewController
            let navigationController = UINavigationController(rootViewController: vc)
            window?.rootViewController = navigationController
        }
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

