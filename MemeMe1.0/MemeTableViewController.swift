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
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MemeTableViewController viewDidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("MemeTableViewController viewWillAppear")
        super.viewWillAppear(animated)
        if memes.count > 0 {
        }
        
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cellForRowAtIndexPath")
        
        let memeCell = tableView.dequeueReusableCell(withIdentifier: "MemeCell")!
        
        let meme = memes[indexPath.row]
        memeCell.textLabel?.text = meme.memeTopText as String
        memeCell.detailTextLabel?.text = meme.memeBottomText as String
        memeCell.imageView?.image = meme.memedImage
        return memeCell
    }
    
    @IBAction func addMeme(_ sender: AnyObject) {
        print("addMeme")
        
        let viewController = ViewController()
        
        present(viewController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAtIndexPath")
        
        let detailViewController = storyboard!.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        let meme = memes[indexPath.row]
        detailViewController.meme = meme
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    // commit editingStyle
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        print("commitEditingStyle")
        if editingStyle == .delete {
            
            //tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            let object = UIApplication.shared.delegate
            let appDelegate = object as! AppDelegate
            appDelegate.memes.remove(at: indexPath.row)
            print("item removed from appDelegate.memes")
            
            var memes:[Meme] {
                let object = UIApplication.shared.delegate
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

