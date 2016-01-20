//
//  ViewController.swift
//  MemeMe1.0
//
//  Created by Laurie Wheeler on 1/10/16.
//  Copyright © 2016 Student. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //@IBOutlet weak var topText: UITextField!

   // @IBOutlet weak var bottomText: UITextField!
    
    //var testImage:UIImageView!
    //var testTopText:UITextField!
    //var testToolBar:UIToolbar!
    
    
    
    @IBOutlet weak var imagePickerView: UIImageView!
    
    @IBOutlet weak var topText: UITextField!
    
    @IBOutlet weak var bottomText: UITextField!
    
    let testTextFieldDelegate = TestTextFieldDelegate()
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : 3.0
    ]
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    struct Meme {
        var memeTopText: NSString
        var memeBottomText: NSString
        var memeImage: UIImage
    }
 
    
    // viewDidLoad, viewWillAppear, viewWillDisappear
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        topText.defaultTextAttributes = memeTextAttributes
        topText.textAlignment = NSTextAlignment.Center
        topText.text = "TOP"
        
        topText.delegate = testTextFieldDelegate
        
        //topText.delegate = self
        
        bottomText.defaultTextAttributes = memeTextAttributes
        bottomText.text = "BOTTOM"
        bottomText.textAlignment = NSTextAlignment.Center
        bottomText.delegate = testTextFieldDelegate
        
        //bottomText.delegate = self
        
       }
    
    override func viewWillAppear(animated: Bool) {
        print("viewWillAppear")
        super.viewWillAppear(animated)
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        shareButton.enabled = false
                
        self.subscribeToKeyboardNotifications()
        self.subscribeToKeyboardWillHideNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        print("viewWillDisappear")
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotifications()
    }
    
    
    
    
    //pick image methods
    
    @IBAction func pickAnImageFromAlbum(sender: AnyObject) {
        print("pickAnImagefromAlbum")
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageFromCamera(sender: AnyObject) {
        print("pickAnImagefromCamera")
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
         print("didFinishPickingImage")
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
        self.imagePickerView.image = image
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        print("imagePickerControllerDidCancel")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    //keyboard methods
    
    func keyboardWillShow(notification: NSNotification) {
        print("keyboardWillShow")
        view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    func keyboardWillHide(notification: NSNotification) {
        print("keyboardWillHide")
        //self.view.frame.origin.y += getKeyboardHeight(notification)
        self.view.frame.origin.y = 0.0
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
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillShowNotification, object: nil)
    }
    
    func subscribeToKeyboardWillHideNotifications() {
        print("subscribeToKeyboardNotifications")
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillShowNotification, object: nil)
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
        let meme = Meme( memeTopText: topText.text!, memeBottomText: bottomText.text!, memeImage: imagePickerView.image!)
    }
    
    func generateMemedImage() -> UIImage {
        print("generateMemedImage")
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        shareButton.enabled = true
        return memedImage
    }
    
    @IBAction func shareMeme(sender: AnyObject) {
        let image = UIImage()
        let shareController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        self.presentViewController(shareController, animated: true, completion: nil)
        
        //shareController.completionWithItemsHandler = saveMeme(memedImage)
        shareController.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
}
