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
    var sectionsInTable: [String] = ["Daily Events","Ongoing Events"]

    func getallEvents() {
        var query = PFQuery(className:"Events")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                println("Successfully retrieved \(objects.count) scores.")
                // Do something with the found objects
                if let objects = objects as? [PFObject] {
                    self.eventList = objects
                    self.tableView.reloadData()
                }
            } else {
                // Log details of the failure
                println("Error: \(error) \(error.userInfo!)")
            }
        }

    }
    
    func getSectionItems(section: Int) -> [AnyObject]! {
        var sectionItems = [AnyObject]()
        
        // loop through the testArray to get the items for this sections's date
        for item in self.eventList {
            // if the item's date equals the section's date then add it
            if section == 0 {
                if (item.objectForKey("ongoing") as Bool == false) {
                    sectionItems.append(item)
                }
            }
            else {
                if (item.objectForKey("ongoing") as Bool == true) {
                    sectionItems.append(item)
                }
            }
        }
        
        return sectionItems
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getallEvents()
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.0/255.0, green: 160.0/255.0, blue: 255.0/255.0, alpha: 255.0/255.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.tableView.tableFooterView = UIView(frame:CGRectZero)
        self.tableView.separatorColor = UIColor.whiteColor()
                //get all events
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as UITableViewHeaderFooterView //recast your view as a UITableViewHeaderFooterView
        header.contentView.backgroundColor = UIColor(red: 0/255, green: 137/255, blue: 218/255, alpha: 1.0) //make the background color light blue
        header.textLabel.textColor = UIColor.whiteColor() //make the text white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 2
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionsInTable[section]
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.getSectionItems(section).count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("EventCell", forIndexPath: indexPath)
                as UITableViewCell
            
            let sectionItems = self.getSectionItems(indexPath.section)
            // get the item for the row in this section
            let event: AnyObject = sectionItems[indexPath.row]
   
            cell.textLabel?.text = event.objectForKey("Name") as NSString

            var dateFormatter: NSDateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy-hh-mm"
            dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC")
            dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
            dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
            let dater = event.objectForKey("Date") as NSDate
            var someDate = dateFormatter.stringFromDate(dater)
            cell.detailTextLabel?.text = "Event Start: " + someDate
            return cell
    }
    override func prepareForSegue(segue: UIStoryboardSegue,
        sender: AnyObject?) {
            
            if segue.identifier == "ShowEventDetails" {
                let detailViewController = segue.destinationViewController
                    as EventDetailsViewController
                let myIndexPath = self.tableView.indexPathForSelectedRow()
                let row = myIndexPath?.row
                let event: AnyObject = self.eventList[row!]
                detailViewController.event_description = event.objectForKey("Description") as NSString
                detailViewController.event_location = event.objectForKey("Location") as NSString
                detailViewController.event_id = event.objectId as NSString
            }
    }


}
