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
    
    override func viewDidAppear(animated: Bool) {
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
