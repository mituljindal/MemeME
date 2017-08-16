//
//  MemeDetailViewController.swift
//  Meme Me
//
//  Created by Mitul Jindal on 15/08/17.
//  Copyright © 2017 mitul jindal. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    var meme: Meme!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = meme.finalMeme
    }
    
    @IBAction func edit(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
        
        controller.topString = self.meme.topString
        controller.bottomString = self.meme.bottomString
        controller.originalImage = self.meme.originalImage
        
        present(controller, animated: true, completion: nil)
    }
}
