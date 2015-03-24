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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        var currentUser = PFUser.currentUser()
        if currentUser != nil {
            // Do stuff with the user
            println("already logged in")
            goToHome()
        } else {
            // Show the signup or login screen
            println("not logged in")
        }
    }

    @IBAction func login(sender: AnyObject) {
        let permissions = ["public_profile", "email"]
        PFFacebookUtils.logInWithPermissions(permissions, {
            (user: PFUser!, error: NSError!) -> Void in
            if let user = user {
                if user.isNew {
                    println("User signed up and logged in through Facebook!")
                    self.goToHome()
                } else {
                    println("User logged in through Facebook!")
                    self.goToHome()
                }
            } else {
                println("Uh oh. The user cancelled the Facebook login.")
            }
        })
        
    }
    @IBOutlet var login: UIButton!
    func goToHome(){
        let vc : AnyObject! = self.storyboard?.instantiateViewControllerWithIdentifier("MainController")
        self.presentViewController(vc as UIViewController, animated: true, completion: nil)
    }
}