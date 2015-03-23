//
//  SocialFeedViewController.swift
//  DerbyDaysApp
//
//  Created by Ryan Sickles on 3/17/15.
//  Copyright (c) 2015 sickles.ryan. All rights reserved.
//

import UIKit

class SocialFeedViewController: UIViewController, MWPhotoBrowserDelegate {
    
    
    var photos = [MWPhoto]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Get user profile pic
        var fbSession = PFFacebookUtils.session()
        var accessToken = fbSession.accessTokenData.accessToken
        let url = NSURL(string: "https://graph.facebook.com/me/picture?type=large&return_ssl_resources=1&access_token="+accessToken)
        let urlRequest = NSURLRequest(URL: url!)
        
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue()) { (response:NSURLResponse!, data:NSData!, error:NSError!) -> Void in
            // Display the image
            let photo = UIImage(data: data)
            var newPhoto = MWPhoto(image: photo)
            self.photos.append(newPhoto)
            var browser = MWPhotoBrowser(delegate: self)
            browser.displayActionButton = true; // Show action button to allow sharing, copying, etc (defaults to YES)
            browser.displayNavArrows = false; // Whether to display left and right nav arrows on toolbar (defaults to NO)
            browser.displaySelectionButtons = false; // Whether selection buttons are shown on each image (defaults to NO)
            browser.zoomPhotosToFill = true; // Images that almost fill the screen will be initially zoomed to fill (defaults to YES)
            browser.alwaysShowControls = false; // Allows to control whether the bars and controls are always visible or whether they fade away to show the photo full (defaults to NO)
            browser.enableGrid = true; // Whether to allow the viewing of all the photo thumbnails on a grid (defaults to YES)
            browser.startOnGrid = false; // Whether to start on the grid of thumbnails instead of the first photo (defaults to NO)
            self.presentViewController(browser, animated: true,completion:nil)
        }
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
    
//
//    - (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index {
//    if (index < _thumbs.count)
//    return [_thumbs objectAtIndex:index];
//    return nil;
//    }
//    
//    
//    - (void)photoBrowser:(MWPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index {
//    NSLog(@"Did start viewing photo at index %lu", (unsigned long)index);
//    }
//    
//    - (BOOL)photoBrowser:(MWPhotoBrowser *)photoBrowser isPhotoSelectedAtIndex:(NSUInteger)index {
//    return [[_selections objectAtIndex:index] boolValue];
//    }
//    
//    
//    - (void)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index selectedChanged:(BOOL)selected {
//    [_selections replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:selected]];
//    NSLog(@"Photo at index %lu selected %@", (unsigned long)index, selected ? @"YES" : @"NO");
//    }
//    
//    - (void)photoBrowserDidFinishModalPresentation:(MWPhotoBrowser *)photoBrowser {
//    // If we subscribe to this method we must dismiss the view controller ourselves
//    NSLog(@"Did finish modal presentation");
//    [self dismissViewControllerAnimated:YES completion:nil];
//    }
//    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
