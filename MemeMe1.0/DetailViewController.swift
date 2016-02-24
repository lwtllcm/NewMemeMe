//
//  DetailViewController.swift
//  MemeMe1.0
//
//  Created by Laurie Wheeler on 2/10/16.
//  Copyright © 2016 Student. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    var meme: Meme?
    
    @IBOutlet weak var detailImageView: UIImageView!
    
    @IBOutlet weak var editButton: UIBarButtonItem!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        print("DetailViewController viewDidLoad")
    }
    
    override func viewWillAppear(animated: Bool) {
        print("DetailViewController viewWillAppear")
        super.viewWillAppear(animated)
        tabBarController?.tabBar.hidden = true
        editButton.enabled = true

        detailImageView.contentMode = .ScaleAspectFit
        detailImageView.image = meme?.memedImage
        
    }
    
    @IBAction func editAction(sender: AnyObject) {
        print("editAction")
        let viewController = storyboard!.instantiateViewControllerWithIdentifier("ViewController") as! ViewController

        viewController.meme = meme
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}

