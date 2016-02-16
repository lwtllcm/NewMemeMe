//
//  MemeCollectionViewDelegate.swift
//  MemeMe1.0
//
//  Created by Laurie Wheeler on 2/9/16.
//  Copyright © 2016 Student. All rights reserved.
//

import Foundation
import UIKit

class  MemeCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    
    func tableView(tableView: UITableView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("didSelectRowAtIndexPath")
        /*
        let object: AnyObject = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController")
        let memeDetailViewController = object as! MemeDetailViewController
        memeDetailViewController.image = memes[indexPath.row]
        
        navigationController!.pushViewController(memeDetailViewController, animated:true)
*/
    }
    
}