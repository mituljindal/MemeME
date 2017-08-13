//
//  ViewController.swift
//  MemeMe 1.0
//
//  Created by Mitul Jindal on 27/07/17.
//  Copyright © 2017 mitul jindal. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController {

    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var navbar: UINavigationBar!
    @IBOutlet weak var photoButton: UIBarButtonItem!
    
    let textFieldDelegate = TextFieldDelegate()
    // let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    
    let memeTextAttributes: [String:Any] = [
        NSStrokeWidthAttributeName: -3.0,
        NSForegroundColorAttributeName: UIColor.white,
        NSStrokeColorAttributeName: UIColor.black,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!
    ]

    func setTextFieldProperties (textField: UITextField, text: String) {
        textField.delegate = textFieldDelegate
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
        textField.adjustsFontSizeToFitWidth = true
        textField.text = text
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setTextFieldProperties(textField: topTextField, text: "TOP")
        setTextFieldProperties(textField: bottomTextField, text: "BOTTOM")
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        unsubscribeFromKeyboardNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shareButton.isEnabled = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if topTextField.isFirstResponder && touch.view != topTextField {
                topTextField.resignFirstResponder()
            } else if bottomTextField.isFirstResponder && touch.view != bottomTextField {
                    bottomTextField.resignFirstResponder()
            }
        }
        super.touchesBegan(touches, with: event)
    }
    
    func keyboardWillShow(_ notification:Notification) {
        
        if bottomTextField.isEditing {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y = 0 - getKeyboardHeight(notification)
            }
        }
    }
    
    func keyboardWillHide(_ notification:Notification) {
        
        self.view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    func configureBars(hidden: Bool) {
        navbar.isHidden = hidden
        toolbar.isHidden = hidden
    }
    
    func save() {
        let meme = Meme(topString: topTextField.text!, bottomString: bottomTextField.text!, originalImage: imagePickerView.image!, finalMeme: generateMemedImage())
        
        (UIApplication.shared.delegate as! AppDelegate).memes.append(meme)
    }
    
    func generateMemedImage() -> UIImage {
        
        configureBars(hidden: true)
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let finalMeme: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        configureBars(hidden: false)
        
        return finalMeme
    }

    @IBAction func shareMeme(_ sender: Any) {
        
        let meme = generateMemedImage()
        
        let controller = UIActivityViewController(activityItems: [meme], applicationActivities: nil)
        controller.completionWithItemsHandler = {
            (_,successful,_,_) in
            if successful {
                let savedMeme = Meme(topString: self.topTextField.text!, bottomString: self.bottomTextField.text!, originalImage: self.imagePickerView.image!, finalMeme: meme)
                UIImageWriteToSavedPhotosAlbum(savedMeme.finalMeme, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
            }
        }
        self.present(controller, animated: true, completion: nil)
    }
    
    func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
}

extension MemeEditorViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func pickImage (sourceType: UIImagePickerControllerSourceType) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func pickImageFromAlbum(_ sender: Any) {
        
        pickImage(sourceType: .photoLibrary)
    }
    
    @IBAction func clickImageFromCamera(_ sender: Any) {
        
        pickImage(sourceType: .camera)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            shareButton.isEnabled = true
            imagePickerView.image = image
            imagePickerView.contentMode = UIViewContentMode.scaleAspectFit
        }
        dismiss(animated: true, completion: nil)
    }
}

