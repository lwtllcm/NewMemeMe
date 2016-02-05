//
//  MemeTableViewController.swift
//  MemeMe1.0
//
//  Created by Laurie Wheeler on 2/2/16.
//  Copyright © 2016 Student. All rights reserved.
//

import UIKit
class  MemeTableViewController : UITableViewController {
    var memes: [Meme]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        memes = applicationDelegate.memes
    }
}

