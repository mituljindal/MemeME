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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if let _ = memes {
            print("1")
        } else {
            let viewController = self.storyboard!.instantiateViewController(withIdentifier: "EditMemeViewController") as! MemeEditorViewController
            print("2")
            present(viewController, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavedMemeCell")!
        let meme = memes[indexPath.row]
        cell.textLabel?.text = meme.topString
        cell.detailTextLabel?.text = meme.bottomString
        cell.imageView?.image = meme.originalImage
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        
        detailViewController.meme = memes[indexPath.row]
        
        navigationController!.pushViewController(detailViewController, animated: true)
    }
}
