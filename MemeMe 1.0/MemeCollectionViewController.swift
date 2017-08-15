//
//  MemeCollectionViewController.swift
//  Meme Me
//
//  Created by Mitul Jindal on 15/08/17.
//  Copyright © 2017 mitul jindal. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UIViewController {
    
    var memes = [Meme]()
    @IBOutlet weak var memesCollection: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
    }

}
