//
//  ViewController.swift
//  MemeMe1.0
//
//  Created by Laurie Wheeler on 1/10/16.
//  Copyright © 2016 Student. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    //outlets
    @IBOutlet weak var imagePickerView: UIImageView!
    
    @IBOutlet weak var topText: UITextField!
    
    @IBOutlet weak var bottomText: UITextField!
    
    //delegate
    let testTextFieldDelegate = TestTextFieldDelegate()
    
    //memeTextAttributes
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : -5.0
    ]
    
    //buttons
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    
    // viewDidLoad, viewWillAppear, viewWillDisappear
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        
        imagePickerView.backgroundColor = UIColor.blackColor()
        
        topText.backgroundColor = UIColor.clearColor()
        topText.defaultTextAttributes = memeTextAttributes
        topText.textAlignment = NSTextAlignment.Center
        topText.text = "TOP"
        topText.adjustsFontSizeToFitWidth = true
        topText.delegate = testTextFieldDelegate
        
        bottomText.defaultTextAttributes = memeTextAttributes
        bottomText.backgroundColor = UIColor.clearColor()
        bottomText.text = "BOTTOM"
        bottomText.textAlignment = NSTextAlignment.Center
        bottomText.adjustsFontSizeToFitWidth = true
        bottomText.delegate = testTextFieldDelegate
        
        shareButton.enabled = false
        
        
       }
    
    override func viewWillAppear(animated: Bool) {
        print("viewWillAppear")
        super.viewWillAppear(animated)
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        subscribeToKeyboardNotifications()
        subscribeToKeyboardWillHideNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        print("viewWillDisappear")
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    //pick image methods
    
    @IBAction func pickAnImageFromAlbum(sender: AnyObject) {
        print("pickAnImagefromAlbum")
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageFromCamera(sender: AnyObject) {
        print("pickAnImagefromCamera")
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        presentViewController(imagePicker, animated: true, completion: nil)
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
         print("didFinishPickingImage")
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
        imagePickerView.image = image
            
        }
        
        dismissViewControllerAnimated(true, completion:{() -> Void in
            self.shareButton.enabled = true
        })
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        print("imagePickerControllerDidCancel")
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //keyboard methods
    
    func keyboardWillShow(notification: NSNotification) {
        print("keyboardWillShow")
        if bottomText.isFirstResponder() {
        view.frame.origin.y = getKeyboardHeight(notification) * -1
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        print("keyboardWillHide")
        view.frame.origin.y = 0.0
    }

    func getKeyboardHeight(notification:NSNotification) -> CGFloat {
        print("getKeyboardHeight")
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
    func subscribeToKeyboardNotifications() {
        print("subscribeToKeyboardNotifications")
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
    }
    
    func subscribeToKeyboardWillHideNotifications() {
        print("subscribeToKeyboardNotifications")
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        print("unsubscribeFromKeyboardNotifications")
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardWillHideNotifications() {
        print("unsubscribeFromKeyboardNotifications")
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    
    
    //text methods
    func textFieldDidBeginEditing( textField: UITextField) {
        print("textFieldDidBeginEditing")
        textField.text = ""
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        print("textFieldShouldReturn")
        return true
    }
    
    //meme methods
    func saveMeme() {
        print("saveMeme")
        
        
        
        let meme = Meme(
            memeTopText: topText.text!,
            memeBottomText: bottomText.text!,
            originalImage: imagePickerView.image!,
            memedImage: generateMemedImage())
        
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        
        //(UIApplication.sharedApplication().delegate as! AppDelegate).memes.append(meme)
        
        //var memesArray = (UIApplication.sharedApplication().delegate as! AppDelegate).memes
        //memesArray.append(meme)
        print(meme)
        
       // let memesTest = (UIApplication.sharedApplication().delegate as! AppDelegate).memes
        
        //print(memesTest.count)
        
        shareButton.enabled = true
    }
    
    func generateMemedImage() -> UIImage {
        print("generateMemedImage")
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawViewHierarchyInRect(view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        shareButton.enabled = true
        return memedImage
    }
    
    @IBAction func shareMeme(sender: AnyObject) {
        print("shareMeme")
        
        let memedImage = generateMemedImage()
       
        
        let shareController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
        
        //helpful info on completion block https://discussions.udacity.com/t/im-not-understanding-the-uiactivityviewcontroller-completionwithitemshandler/14271/9
        
        shareController.completionWithItemsHandler = {activity, completed, items, error in
            if completed {
                self.saveMeme()
                self.dismissViewControllerAnimated(true, completion: nil)
                }
            }
        
        presentViewController(shareController, animated: true, completion: nil)
     }
    
    @IBAction func cancelButtonAction(sender: AnyObject) {
        print("cancelButtonAction")
        
        //var initialController:ViewController
        
        
        //initialController = storyboard?.instantiateViewControllerWithIdentifier("ViewController") as!
        //    ViewController
               
       // presentViewController(initialController, animated: true, completion: nil)
        
       
    
        self.dismissViewControllerAnimated(true, completion: nil)
        
           }

        
    
    
}
