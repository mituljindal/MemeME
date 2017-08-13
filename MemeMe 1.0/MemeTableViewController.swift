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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavedMemeCell")!
        let meme = memes[indexPath.row]
        cell.textLabel?.text = meme.topString
        cell.detailTextLabel?.text = meme.bottomString
        cell.imageView?.image = meme.originalImage
        return cell
    }
}
