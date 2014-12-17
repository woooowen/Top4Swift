//
//  ViewController.swift
//  SwiftSideMenu
//
//  Created by Evgeny on 03.08.14.
//  Copyright (c) 2014 Evgeny Nazarov. All rights reserved.
//

import UIKit

class searchViewController: UIViewController,UICollectionViewDataSource {
    
    


    



    
    var cellImages = ["default.png"]
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //初始化collectionView
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return cellImages.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("searchCell", forIndexPath: indexPath) as TopCollectionViewCell
        cell.cellImage.image = UIImage(named: cellImages[indexPath.row])
//        image.image = UIImage(named: cellImages[indexPath.row])
        return cell
    }
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int{
        
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        
    }
    
}

