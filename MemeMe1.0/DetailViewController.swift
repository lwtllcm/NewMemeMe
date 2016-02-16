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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("DetailViewController viewDidLoad")
     }

    override func viewWillAppear(animated: Bool) {
        print("DetailViewController viewWillAppear")
        super.viewWillAppear(animated)
       
        print(meme)
        detailImageView.image = meme?.memedImage
        
        
        }

            
    

}

