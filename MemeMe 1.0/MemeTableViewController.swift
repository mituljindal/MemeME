//
//  MemeTableViewController.swift
//  Meme Me
//
//  Created by Mitul Jindal on 15/08/17.
//  Copyright © 2017 mitul jindal. All rights reserved.
//

import UIKit

class MemeTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var memes = [Meme]()
    @IBOutlet weak var memesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.memes = appDelegate.memes
        
        memesTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memeTableCell")!
        let meme = memes[indexPath.row]
        
        cell.textLabel?.text = meme.topString
        cell.imageView?.image = meme.originalImage
        cell.detailTextLabel?.text = meme.bottomString
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let memeController = storyboard?.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        
        memeController.meme = self.memes[(indexPath as NSIndexPath).row]
        
        self.navigationController?.pushViewController(memeController, animated: true)
    }
}
