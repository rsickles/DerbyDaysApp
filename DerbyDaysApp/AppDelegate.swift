//
//  AppDelegate.swift
//  DerbyDaysApp
//
//  Created by Ryan Sickles on 3/11/15.
//  Copyright (c) 2015 sickles.ryan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        Parse.setApplicationId("U1bP0YPu2bJV6WfzBvdUldRB8nuRoGEMeyzrDygD", clientKey: "AeIi4piCfkeM191RCGUh5T79c2af31b9Dp7lPVcT")
        PFFacebookUtils.initializeFacebook()
        
        // Assign tab bar item with titles
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vs: UITabBarController = storyboard.instantiateViewControllerWithIdentifier("MainController") as UITabBarController
        let tabBar: UITabBar = vs.tabBar
        let item1: UITabBarItem = tabBar.items?[0] as UITabBarItem
        return true
    }

    func application(application: UIApplication,
        openURL url: NSURL,
        sourceApplication: String?,
        annotation: AnyObject?) -> Bool {
            return FBAppCall.handleOpenURL(url, sourceApplication:sourceApplication,
                withSession:PFFacebookUtils.session())
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        FBAppCall.handleDidBecomeActiveWithSession(PFFacebookUtils.session())
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

