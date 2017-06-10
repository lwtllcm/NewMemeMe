//
//  ViewController.swift
//  MemeMe1.0
//
//  Created by Laurie Wheeler on 1/10/16.
//  Copyright © 2016 Student. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var meme: Meme?
    
    //outlets
    @IBOutlet weak var imagePickerView: UIImageView!
    
    @IBOutlet weak var topText: UITextField!
    
    @IBOutlet weak var bottomText: UITextField!
    
    //delegate
    let textFieldDelegate = TextFieldDelegate()
    
    //memeTextAttributes
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.black,
        NSForegroundColorAttributeName : UIColor.white,
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : -5.0
    ] as [String : Any]
    
    //buttons
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    
    // viewDidLoad, viewWillAppear, viewWillDisappear
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        
        if let image = meme?.originalImage {
            print("meme passed")
            imagePickerView.backgroundColor = UIColor.black
            imagePickerView.image = image
            setTextFields(topText)

            topText.text = " "
            topText.isEnabled = true
            
            setTextFields(bottomText)

            bottomText.text = " "
            bottomText.isEnabled = true
            imagePickerView.contentMode = .scaleAspectFit
            
            navigationController?.isNavigationBarHidden = false
            
            shareButton.isEnabled = true
            cancelButton.isEnabled = true
        }
        else {
        
        imagePickerView.backgroundColor = UIColor.black
        
        setTextFields(topText)
        topText.text = "TOP"
        
        setTextFields(bottomText)
        bottomText.text = "BOTTOM"
        shareButton.isEnabled = false
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
        super.viewWillAppear(animated)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
        
        subscribeToKeyboardNotifications()
        subscribeToKeyboardWillHideNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear")
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    func setTextFields(_ textField:UITextField) {
        print("setTextFields")
        textField.defaultTextAttributes = memeTextAttributes
        textField.backgroundColor = UIColor.clear
        
        textField.textAlignment = NSTextAlignment.center
        textField.adjustsFontSizeToFitWidth = true
        textField.delegate = textFieldDelegate
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    //pick image methods
    
    @IBAction func pickAnImageFromAlbum(_ sender: AnyObject) {
        print("pickAnImagefromAlbum")
        let sourceType = UIImagePickerControllerSourceType.photoLibrary
        pickImage(sourceType)
    }
    
    @IBAction func pickAnImageFromCamera(_ sender: AnyObject) {
        print("pickAnImagefromCamera")
        let sourceType = UIImagePickerControllerSourceType.camera
        pickImage(sourceType)
        
    }
    
    func pickImage(_ sourceImageType:UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceImageType
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("didFinishPickingImage")
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
            imagePickerView.contentMode = .scaleAspectFit
            
        }
        
     
        
        dismiss(animated: true, completion:{() -> Void in
            self.shareButton.isEnabled = true
        })
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("imagePickerControllerDidCancel")
        dismiss(animated: true, completion: nil)
    }
    
    //keyboard methods
    
    func keyboardWillShow(_ notification: Notification) {
        print("keyboardWillShow")
        if bottomText.isFirstResponder {
            view.frame.origin.y = getKeyboardHeight(notification) * -1
        }
    }
    
    func keyboardWillHide(_ notification: Notification) {
        print("keyboardWillHide")
        if bottomText.isFirstResponder {
            view.frame.origin.y = 0.0
        }
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        print("getKeyboardHeight")
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        print("subscribeToKeyboardNotifications")
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    
    func subscribeToKeyboardWillHideNotifications() {
        print("subscribeToKeyboardNotifications")
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        print("unsubscribeFromKeyboardNotifications")
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    
    func unsubscribeFromKeyboardWillHideNotifications() {
        print("unsubscribeFromKeyboardNotifications")
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    //text methods
    func textFieldDidBeginEditing( _ textField: UITextField) {
        print("textFieldDidBeginEditing")
        textField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn")
        return true
    }
    
    //meme methods
    func saveMeme() {
        print("saveMeme")
        let meme = Meme(
            memeTopText: topText.text! as NSString,
            memeBottomText: bottomText.text! as NSString,
            originalImage: imagePickerView.image!,
            memedImage: generateMemedImage())
        
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        
        shareButton.isEnabled = true
    }
    
    func generateMemedImage() -> UIImage {
        print("generateMemedImage")
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawHierarchy(in: view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        shareButton.isEnabled = true
        return memedImage
    }
    
    @IBAction func shareMeme(_ sender: AnyObject) {
        print("shareMeme")
        
        let memedImage = generateMemedImage()
        let shareController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
        //helpful info on completion block https://discussions.udacity.com/t/im-not-understanding-the-uiactivityviewcontroller-completionwithitemshandler/14271/9
        
        shareController.completionWithItemsHandler = {activity, completed, items, error in
            if completed {
                self.saveMeme()
                self.dismiss(animated: true, completion: nil)
            }
        }
        
        present(shareController, animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonAction(_ sender: AnyObject) {
        print("cancelButtonAction")
        dismiss(animated: true, completion: nil)
    }
}
