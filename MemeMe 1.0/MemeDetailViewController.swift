//
//  MemeDetailViewController.swift
//  Meme Me
//
//  Created by Mitul Jindal on 14/08/17.
//  Copyright © 2017 mitul jindal. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    var meme: Meme!
    
    @IBOutlet weak var memeView: UIImageView!
    
    override func viewDidLoad() {
        memeView.image = meme.finalMeme
    }
    
}
