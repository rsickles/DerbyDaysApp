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
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet var amount_raised: UILabel!
    
    
    @IBOutlet var countdown: UILabel!

    
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
            self.amount_raised.text = object.objectForKey("amount_raised") as? String
            println("Successfully retrieved the object.")
        }
    }
    }
}

