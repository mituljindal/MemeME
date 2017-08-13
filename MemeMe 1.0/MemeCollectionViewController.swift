//
//  MemeCollectionViewController.swift
//  Meme Me
//
//  Created by Mitul Jindal on 13/08/17.
//  Copyright © 2017 mitul jindal. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var memes: [Meme]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
    }
}
