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
        let object = UIApplication.shared.delegate
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
        
        flowLayout.itemSize = CGSize(width: 100.0, height: 100.0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("MemeCollectionViewController viewWillAppear")
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("collectionView numberOfItemsInSection")
        return memes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("MemeCollectionViewController cellForItemAtIndexPath")
        let memeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
        let meme = memes[indexPath.row]
        
        memeCell.memeImageView.image = meme.memedImage
        return memeCell
    }
    
    @IBAction func addMeme(_ sender: AnyObject) {
        print("addMeme")
        let viewController = ViewController()
        present(viewController, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectItemAtIndexPath")
        
        let detailViewController = storyboard!.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        let meme = memes[indexPath.row]
        detailViewController.meme = meme
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
