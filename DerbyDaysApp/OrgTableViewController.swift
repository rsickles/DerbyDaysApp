//
//  OrgTableViewController.swift
//  DerbyDaysApp
//
//  Created by Ryan Sickles on 3/19/15.
//  Copyright (c) 2015 sickles.ryan. All rights reserved.
//

import UIKit

class OrgTableViewController: UITableViewController {
    
    var orgs: [String] = ["Sigma Chi", "Delta Gamma", "Kappa Kappa Gamma", "Delta Delta Delta", "Other"]
    var lastSelectedIndexPath:NSIndexPath?
    var org_selected: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func done(sender: UIBarButtonItem) {
        println("Finished Selecting organization")
        println(lastSelectedIndexPath)
            if(self.lastSelectedIndexPath != nil) {
        var currentUser = PFUser.currentUser().objectId
        var query = PFQuery(className:"_User")
        query.getObjectInBackgroundWithId(currentUser) {
            (user: PFObject!, error: NSError!) -> Void in
            if error != nil {
                println(error)
            } else {
                user["organization"] = self.org_selected
                user.saveEventually({ (bool:Bool, error:NSError!) -> Void in
                    if bool == true {
                        println("Saved")
                    }
                })
            }
        }
        let vc : AnyObject! = self.storyboard?.instantiateViewControllerWithIdentifier("Home")
        self.presentViewController(vc as UIViewController, animated: true, completion: nil)
        }
        else {
            //display error that must select organization
            self.displayAlert()
        }
    }
    // MARK: - Table view data source

    func displayAlert(){
        let title = "No Organization Selected"
        let message = "Please Select An Organization!"
        let OkText = "OK"
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let alertaction = UIAlertAction(title: OkText, style: UIAlertActionStyle.Cancel, handler: nil)
        alert.addAction(alertaction)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.orgs.count;
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        cell.accessoryType = (self.lastSelectedIndexPath?.row == indexPath.row) ? .Checkmark : .None
        cell.textLabel?.text = self.orgs[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if indexPath.row != self.lastSelectedIndexPath?.row {
            if let lastSelectedIndexPath = self.lastSelectedIndexPath {
                let oldCell = tableView.cellForRowAtIndexPath(lastSelectedIndexPath)
                oldCell?.accessoryType = .None
            }
            
            let newCell = tableView.cellForRowAtIndexPath(indexPath)
            newCell?.accessoryType = .Checkmark
            self.org_selected = self.orgs[indexPath.row]
            self.lastSelectedIndexPath = indexPath
        }

    }
}
