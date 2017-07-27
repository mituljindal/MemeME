//
//  ViewController.swift
//  MemeMe 1.0
//
//  Created by Mitul Jindal on 27/07/17.
//  Copyright © 2017 mitul jindal. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imagePickerView: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func pickImage(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
        //imagePicker.dismiss(animated: true, completion: nil)
    }

}
