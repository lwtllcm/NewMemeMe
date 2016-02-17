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
    
    //var memes: [Meme]!
    var testMemes = ["test1","test2","test3"]
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        print("MemeTableViewController viewDidLoad")
        
        //let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
       // memes = applicationDelegate.memes
        
        print(memes.count)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        print("MemeTableViewController viewWillAppear")
        super.viewWillAppear(animated)
        
        //let object = (UIApplication.sharedApplication().delegate as! AppDelegate)
        //let appDelegate = object as AppDelegate
        //memes = appDelegate.memes
        
        print(memes.count)
        if memes.count > 0 {
        print(memes[0].memeTopText)
        }
        
        tableView.reloadData()
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberOfRowsInSection")
        //let object = (UIApplication.sharedApplication().delegate as! AppDelegate)
        //let appDelegate = object as AppDelegate
       // memes = appDelegate.memes

        //print(memes.count)
        return memes.count
        
        //return testMemes.count
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("cellForRowAtIndexPath")
        
        //let memeCell = tableView.dequeueReusableCellWithIdentifier("MemeCell")! as UITableViewCell
        let memeCell = tableView.dequeueReusableCellWithIdentifier("MemeCell")!
        
        //let meme = memes[indexPath.row]
       //memeCell.imageView?.image = memes[indexPath.row]
        
        //let object = (UIApplication.sharedApplication().delegate as! AppDelegate)
        //let appDelegate = object as AppDelegate
        //memes = appDelegate.memes
        
       let meme = memes[indexPath.row]
        //let testMeme = testMemes[indexPath.row]
        
       // memeCell.imageView?.image = memes[indexPath.row].memedImage
       // print(meme.memeTopText as String)
        //memeCell.textLabel?.text = memes[indexPath.row].memeTopText as String
        
        memeCell.textLabel?.text = meme.memeTopText as String
        memeCell.detailTextLabel?.text = meme.memeBottomText as String
        memeCell.imageView?.image = meme.memedImage
       // memeCell.textLabel?.text = testMeme
        
        
        return memeCell
    }
    
    @IBAction func addMeme(sender: AnyObject) {
        print("addMeme")
        
        let viewController = ViewController()

        
        presentViewController(viewController, animated: true, completion: nil)
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("didSelectRowAtIndexPath")
        
        /*
        let detailViewController = DetailViewController()
        let meme = memes[indexPath.row]
        detailViewController.detailImage = meme.memedImage
        
        //let detailViewController = self.storyboard!.instantiateViewControllerWithIdentifier("DetailViewController") as!UIViewController
        self.navigationController?.pushViewController(detailViewController, animated: true)
        */
        
        let detailViewController = storyboard!.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        let meme = memes[indexPath.row]
        detailViewController.meme = meme
        self.navigationController?.pushViewController(detailViewController, animated: true)
        
    }

    

}

