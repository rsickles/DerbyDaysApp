//
//  SigmaChiViewController.swift
//  DerbyDaysApp
//
//  Created by Ryan Sickles on 3/19/15.
//  Copyright (c) 2015 sickles.ryan. All rights reserved.
//

import UIKit

class SigmaChiViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.info.userInteractionEnabled = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBOutlet var info: UITextView!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
