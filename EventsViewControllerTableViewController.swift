//
//  EventsViewControllerTableViewController.swift
//  DerbyDaysApp
//
//  Created by Ryan Sickles on 3/16/15.
//  Copyright (c) 2015 sickles.ryan. All rights reserved.
//

import UIKit

class EventsViewControllerTableViewController: UITableViewController {

    var eventList: NSArray = [PFObject]()
    

    func getallEvents() {
        var eventData = [PFObject]()
        var query = PFQuery(className:"Events")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                println("Successfully retrieved \(objects.count) scores.")
                // Do something with the found objects
                if let objects = objects as? [PFObject] {
                    
                    for object in objects as [PFObject]{
                        
                        eventData.append(object as PFObject)
                    }
                    self.eventList = objects
                    self.tableView.reloadData()
                    println(self.eventList)
                    
                }
            } else {
                // Log details of the failure
                println("Error: \(error) \(error.userInfo!)")
            }
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getallEvents()
        //get all events
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        println(self.eventList.count)
        let count = self.eventList.count as Int
        return (count)
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("EventCell", forIndexPath: indexPath)
                as UITableViewCell
            let event: AnyObject = self.eventList[indexPath.row]
            cell.textLabel?.text = event.objectForKey("Name") as NSString
            
            
            
            var dateFormatter: NSDateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy-hh-mm"
            dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC")
            dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
            dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
            let dater = event.objectForKey("Date") as NSDate
            var someDate = dateFormatter.stringFromDate(dater)
            cell.detailTextLabel?.text = someDate
            return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
