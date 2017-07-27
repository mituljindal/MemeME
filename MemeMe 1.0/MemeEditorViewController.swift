//
//  ViewController.swift
//  MemeMe 1.0
//
//  Created by Mitul Jindal on 27/07/17.
//  Copyright © 2017 mitul jindal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imagePickerView: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func pickImage(_ sender: Any) {
        
        let pickerController = UIImagePickerController()
        self.present(pickerController, animated: true, completion: nil)
    }

}

