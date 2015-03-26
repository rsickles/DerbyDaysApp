//
//  TabBarViewController.swift
//  DerbyDaysApp
//
//  Created by Ryan Sickles on 3/25/15.
//  Copyright (c) 2015 sickles.ryan. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController{

    override func viewDidLoad() {
        super.viewDidLoad()
        self.xyz.barTintColor = UIColor(red: 0.0/255.0, green: 137.0/255.0, blue: 218.0/255.0, alpha: 100.0/255.0)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState:.Normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState:.Selected)
        for item in self.xyz.items as [UITabBarItem] {
            if let image = item.image {
                item.image = image.imageWithColor(UIColor.whiteColor()).imageWithRenderingMode(.AlwaysOriginal)
            }
        }
        // Do any additional setup after loading the view.
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet var xyz: UITabBar!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
