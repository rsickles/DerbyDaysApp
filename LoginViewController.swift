//
//  LoginViewController.swift
//  DerbyDaysApp
//
//  Created by Ryan Sickles on 3/12/15.
//  Copyright (c) 2015 sickles.ryan. All rights reserved.
//
import Foundation
import UIKit

class LoginViewController: UIViewController,FBLoginViewDelegate {
    
    @IBOutlet var fbLoginView : FBLoginView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fbLoginView.delegate = self
        self.fbLoginView.readPermissions = ["public_profile", "email", "user_friends"]
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func loginViewShowingLoggedInUser(loginView : FBLoginView!) {
        println("User Logged In")
        println("This is where you perform a segue.")
    }
    
    func loginViewFetchedUserInfo(loginView : FBLoginView!, user: FBGraphUser){
        println("User Name: \(user)")
        loginMethod(user)

    }
    
    func loginViewShowingLoggedOutUser(loginView : FBLoginView!) {
        println("User Logged Out")
    }
    
    func loginView(loginView : FBLoginView!, handleError:NSError) {
        println("Error: \(handleError.localizedDescription)")
    }
    
    func loginMethod(user: FBGraphUser) {
        var new_user = PFUser()
        let email = user.objectForKey("email") as String
        new_user.username = user.name!
        new_user.setObject("Email", forKey: email)
        new_user.signUpInBackgroundWithBlock {
            (succeeded: Bool!, error: NSError!) -> Void in
            if error == nil {
                // Hooray! Let them use the app now.
                println("HEHE")
            } else {
                //show error
                println(error)
            }
        }
    }
    
    @IBAction func login(sender: AnyObject) {
        let permissions = ["public_profile", "email", "user_friends"]
        PFFacebookUtils.logInWithPermissions(permissions, {
            (user: PFUser!, error: NSError!) -> Void in
            if let user = user {
                if user.isNew {
                    println("User signed up and logged in through Facebook!")
                } else {
                    println("User logged in through Facebook!")
                }
            } else {
                println("Uh oh. The user cancelled the Facebook login.")
            }
        })
        
    }
}