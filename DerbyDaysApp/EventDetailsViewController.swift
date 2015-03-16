//
//  EventDetailsViewController.swift
//  DerbyDaysApp
//
//  Created by Ryan Sickles on 3/16/15.
//  Copyright (c) 2015 sickles.ryan. All rights reserved.
//

import UIKit

class EventDetailsViewController: UIViewController {


    var event_description: String?
    var event_location: String?
    var event_id: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println(event_description)
        println(event_location)
        println(event_id)
        self.description_info.text = event_description
        self.location_info.text = event_location

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBOutlet var attending_button: UIButton!
    @IBAction func attending(sender: UIButton) {
        var query = PFQuery(className:"Events")
        println(sender.titleLabel)
        if(sender.titleLabel?.text == "I am attending!") {
            sender.setTitle("I am no longer attending :(", forState: UIControlState.Normal)
            query.getObjectInBackgroundWithId(self.event_id) {
                (event: PFObject!, error: NSError!) -> Void in
                if error != nil {
                    println(error)
                } else {
                    event.incrementKey("attendees")
                    event.saveEventually({ (Bool, NSError) -> Void in
                        
                    })
                }
            }
        }
        //decrement value
        else {
            sender.setTitle("I am attending!", forState: UIControlState.Normal)
            query.getObjectInBackgroundWithId(self.event_id) {
                (event: PFObject!, error: NSError!) -> Void in
                if error != nil {
                    println(error)
                } else {
                    event.incrementKey("attendees", byAmount: -1)
                    event.saveEventually({ (Bool, NSError) -> Void in
                        
                    })
                }
            }
        }

    }

    @IBOutlet var description_info: UILabel!
    @IBOutlet var location_info: UILabel!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
