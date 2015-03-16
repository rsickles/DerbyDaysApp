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
        var dateString = "2015-04-04" // change to your date format
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        
        var someDate = dateFormatter.dateFromString(dateString)
//        MZTimerLabel *timer = [[MZTimerLabel alloc] initWithLabel:aUILabel andTimerType:MZTimerLabelTypeTimer];
//        [timer setCountDownTime:60];
//        [timer start];
        //MZTimerLabelTypeTimer timer = self.countdown
       

    }
    
    required init(coder aDecoder: NSCoder) {
        countdown_timer = MZTimerLabelTypeTimer
        super.init(coder: aDecoder)
        // ERROR: Cannot assign to the result of this expression
        //countdown_timer = self.countdown
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet var amount_raised: UILabel!
    private let countdown_timer: MZTimerLabelType
    

    @IBOutlet var countdown: UILabel!

    
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

