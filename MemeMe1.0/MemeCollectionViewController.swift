//
//  MemeCollectionViewController.swift
//  MemeMe1.0
//
//  Created by Laurie Wheeler on 2/2/16.
//  Copyright © 2016 Student. All rights reserved.
//

import Foundation
import UIKit

class  MemeCollectionViewController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
   
    var memes:[Meme] {
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    @IBOutlet var collectionView: UICollectionView!

    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MemeCollectionViewController viewDidLoad")
        let space: CGFloat = 3.0
        //let dimension = (view.frame.size.width - (2 * space) / 3.0)
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        
        //flowLayout.itemSize = CGSizeMake(dimension, dimension)
        
        flowLayout.itemSize = CGSizeMake(100.0, 100.0)
    }
    
    override func viewWillAppear(animated: Bool) {
        print("MemeCollectionViewController viewWillAppear")
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = false
        self.collectionView.reloadData()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("collectionView numberOfItemsInSection")
        return memes.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        print("MemeCollectionViewController cellForItemAtIndexPath")
        let memeCell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollectionViewCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        let meme = memes[indexPath.row]
        
        memeCell.memeImageView.image = meme.memedImage
        return memeCell
    }
    
    @IBAction func addMeme(sender: AnyObject) {
        print("addMeme")
        let viewController = ViewController()
        presentViewController(viewController, animated: true, completion: nil)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    print("didSelectItemAtIndexPath")
    
    let detailViewController = storyboard!.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
    let meme = memes[indexPath.row]
    detailViewController.meme = meme
    self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
