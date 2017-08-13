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
        
        let space: CGFloat = 3.0
        let dimension: CGFloat
        if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft || UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
                dimension = (self.view.frame.size.height - (2 * space)) / 5.0
        } else {
            dimension = (self.view.frame.size.width - (2 * space)) / 3.0
        }
        
        flowLayout.minimumLineSpacing = space
        flowLayout.minimumInteritemSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCellCollection", for: indexPath) as! MemeCollectionViewCell
        
        let meme = memes[indexPath.row]
        
        cell.memeImage?.image = meme.finalMeme
        //cell.topLabel?.text = meme.topString
        //cell.bottomLabel?.text = meme.bottomString
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailViewController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        
        detailViewController.meme = memes[indexPath.row]
        
        navigationController!.pushViewController(detailViewController, animated: true)
    }
}
