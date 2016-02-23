//
//  MemeTableViewController.swift
//  MemeMe1.0
//
//  Created by Laurie Wheeler on 2/2/16.
//  Copyright © 2016 Student. All rights reserved.
//

import UIKit
class  MemeTableViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var memes:[Meme] {
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MemeTableViewController viewDidLoad")
    }
    
    override func viewWillAppear(animated: Bool) {
        print("MemeTableViewController viewWillAppear")
        super.viewWillAppear(animated)
        if memes.count > 0 {
        }
        
        tableView.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("cellForRowAtIndexPath")
        
        let memeCell = tableView.dequeueReusableCellWithIdentifier("MemeCell")!
        
        let meme = memes[indexPath.row]
        memeCell.textLabel?.text = meme.memeTopText as String
        memeCell.detailTextLabel?.text = meme.memeBottomText as String
        memeCell.imageView?.image = meme.memedImage
        return memeCell
    }
    
    @IBAction func addMeme(sender: AnyObject) {
        print("addMeme")
        
        let viewController = ViewController()
        
        presentViewController(viewController, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("didSelectRowAtIndexPath")
        
        let detailViewController = storyboard!.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        let meme = memes[indexPath.row]
        detailViewController.meme = meme
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        print("commitEditingStyle")
        if editingStyle == .Delete {
            
            //tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            let object = UIApplication.sharedApplication().delegate
            let appDelegate = object as! AppDelegate
            appDelegate.memes.removeAtIndex(indexPath.row)
            print("item removed from appDelegate.memes")
            
            var memes:[Meme] {
                let object = UIApplication.sharedApplication().delegate
                let appDelegate = object as! AppDelegate
                return appDelegate.memes
            }
            
            tableView.reloadData()
            
        }
        else {
            print("other Editing Style")
        }
        
    }
}

