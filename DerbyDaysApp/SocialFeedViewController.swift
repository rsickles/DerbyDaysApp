//
//  SocialFeedViewController.swift
//  DerbyDaysApp
//
//  Created by Ryan Sickles on 3/24/15.
//  Copyright (c) 2015 sickles.ryan. All rights reserved.
//

import UIKit

class SocialFeedViewController: UIViewController, MWPhotoBrowserDelegate, UINavigationControllerDelegate {
    
    
    var photos = [MWPhoto]()
    
    @IBAction func show_photos(sender: UIButton) {
        var browser = MWPhotoBrowser(delegate: self)
        browser.displayActionButton = true; // Show action button to allow sharing, copying, etc (defaults to YES)
        browser.displayNavArrows = true; // Whether to display left and right nav arrows on toolbar (defaults to NO)
        browser.displaySelectionButtons = false; // Whether selection buttons are shown on each image (defaults to NO)
        browser.zoomPhotosToFill = true; // Images that almost fill the screen will be initially zoomed to fill (defaults to YES)
        browser.alwaysShowControls = false; // Allows to control whether the bars and controls are always visible or whether they fade away to show the photo full (defaults to NO)
        browser.enableGrid = true; // Whether to allow the viewing of all the photo thumbnails on a grid (defaults to YES)
        browser.startOnGrid = true; // Whether to start on the grid of thumbnails instead of the first photo (defaults to NO)
        var navigationController = UINavigationController(rootViewController: browser)
        navigationController.delegate = self
        self.presentViewController(navigationController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // Get user profile pic
        var friendsRequest : FBRequest = FBRequest(forGraphPath: "/780446232040768/photos")
        friendsRequest.startWithCompletionHandler{(connection:FBRequestConnection!, result:AnyObject!, error:NSError!) -> Void in
            let resultdict = result as NSDictionary
            let images : NSArray = resultdict.objectForKey("data") as NSArray
            for var index = 0; index < images.count; ++index  {
                let stuff : NSDictionary = images.objectAtIndex(index) as NSDictionary
                let stuff2 : NSArray = stuff.objectForKey("images") as NSArray
                let stuff3 : NSDictionary = stuff2.objectAtIndex(stuff2.count-1) as NSDictionary
                // println(images)
                let stuff4: NSString = stuff3.objectForKey("source") as NSString
                // Display the image
                let url = NSURL(string: stuff4)
                let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
                var photo = UIImage(data: data!)
                var newPhoto = MWPhoto(image: photo)
                newPhoto.caption = "Meek mill"
                self.photos.append(newPhoto)
            }
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //    MWPhotoBrowserDelegate Methods
    func numberOfPhotosInPhotoBrowser(photoBrowser: MWPhotoBrowser!) -> UInt {
        return UInt(self.photos.count)
    }
    
    
    func photoBrowser(photoBrowser: MWPhotoBrowser!, photoAtIndex index: UInt) -> MWPhotoProtocol! {
        
        return self.photos[Int(index)]
    }
    
    func photoBrowser(photoBrowser: MWPhotoBrowser!, thumbPhotoAtIndex index: UInt) -> MWPhotoProtocol! {
        if(index < UInt(self.photos.count)) {
            return self.photos[Int(index)]
        }
        return nil
    }

}