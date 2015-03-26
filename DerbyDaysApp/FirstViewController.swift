//
//  FirstViewController.swift
//  DerbyDaysApp
//
//  Created by Ryan Sickles on 3/11/15.
//  Copyright (c) 2015 sickles.ryan. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBOutlet var team_1: UILabel!
    
    @IBOutlet var team_2: UILabel!
    @IBOutlet var amount_raised: UILabel!
    @IBOutlet var team_3: UILabel!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func showDonatePage(sender: UIButton) {
        let webViewController = SVModalWebViewController(address: "https://www.gofundme.com/cmuderbydays/donate")
        self.presentViewController(webViewController, animated: true, completion: nil)
    }
    override func viewDidAppear(animated: Bool) {
        var query = PFQuery(className:"Scoreboard")
        query.getFirstObjectInBackgroundWithBlock {
            (object: PFObject!, error: NSError!) -> Void in
            if (error != nil || object == nil) {
                println("The getFirstObject request failed.")
            }
        else {
            // The find succeeded.
                println(object.objectForKey("amount_raised"))
            self.amount_raised.text = "$ " + (object.objectForKey("amount_raised") as? String)!
            self.team_1.text = "1. " + (object.objectForKey("team_1") as? String)! + "   " + (object.objectForKey("points_1") as? String)!
                self.team_2.text = "2. " + (object.objectForKey("team_2") as? String)! + "   " + (object.objectForKey("points_2") as? String)!
                self.team_3.text = "3. " + (object.objectForKey("team_3") as? String)! + "   " + (object.objectForKey("points_3") as? String)!
            println("Successfully retrieved the object.")
        }
    }
    }
}

