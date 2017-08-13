//
//  MemeTableViewController.swift
//  Meme Me
//
//  Created by Mitul Jindal on 13/08/17.
//  Copyright © 2017 mitul jindal. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {
    
    @IBOutlet weak var tableLayout: UITableView!
    
    var memes: [Meme]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
    }
}
