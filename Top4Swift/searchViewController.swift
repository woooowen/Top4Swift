//
//  ViewController.swift
//  SwiftSideMenu
//
//  Created by Evgeny on 03.08.14.
//  Copyright (c) 2014 Evgeny Nazarov. All rights reserved.
//

import UIKit

class searchViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,HttpProtocol{
    
    var eHttp = HttpController()
    var tmpListData: NSMutableArray = NSMutableArray()
    var listData: NSMutableArray = NSMutableArray()
    var page = 1 //page
    var imageCache = Dictionary<String,UIImage>()
    var imageCacheHeight = Dictionary<String,CGFloat>()
    var tmpFloat: CGFloat = CGFloat()
    
    //图片尺寸
    
    
    let cellLabelUname = 1
    let cellImg = 2

    @IBOutlet weak var search: UISearchBar!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //初始化collectionView
        collectionView.hidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        if(self.listData.count == 0){
            
            if(self.tmpListData.count != 0){
                
                self.listData = self.tmpListData
            }
        }
        return listData.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("searchCell", forIndexPath: indexPath) as TopCollectionViewCell
        var rowData: NSDictionary = self.listData[indexPath.row] as NSDictionary
        let imgUrl = rowData["cover"]? as String
        var img = cell.viewWithTag(cellImg) as UIImageView
        img.image = UIImage(named: "default.png")
        if(imgUrl != ""){
            let image = self.imageCache[imgUrl] as UIImage?
            if(image == nil){
                let imageUrl = NSURL(string: imgUrl)
                let request: NSURLRequest = NSURLRequest(URL: imageUrl!)
                //异步获取
                NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse!,data: NSData!,error: NSError!)-> Void in
                    let imgTmp = UIImage(data: data)
                    img.image = imgTmp
                    
                    self.imageCache[imgUrl] = imgTmp
                    self.imageCacheHeight[imgUrl] = imgTmp?.size.height
                    
                    let imgSize = CGSizeMake(150, self.imageCacheHeight[imgUrl]!)

                    
//                    let newFrame = self.invalidationContextForBoundsChange(imgSize)
                    
                    
                })
            }else{
                img.image = image
            }
        }
        
        //标题
        var label1 = cell.viewWithTag(cellLabelUname) as UILabel
        label1.text = rowData["user"]?["uname"] as NSString
        
        return cell
    }
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int{
        return 1
    }
    
    //cell 尺寸,根据图片尺寸来定义每个cell的高度
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        
        let imageUrl = self.listData[indexPath.row]["cover"] as String
        
        let image = self.imageCache[imageUrl] as UIImage?
        if(image == nil){
            let imgurl = NSURL(string: imageUrl)
            let request: NSURLRequest = NSURLRequest(URL: imgurl!)
            let error = NSErrorPointer()
            
            //异步获取
            
            
//            var responseData = NSURLConnection.sendSynchronousRequest(request,returningResponse: AutoreleasingUnsafePointer<NSURLResponse>, error:nil) as NSData
//            if error != nil
//            {
//                // You can handle error response here
//            }
//            else
//            {
//                //Converting data to String
//                var responseStr:NSString = NSString(data:responseData, encoding:NSUTF8StringEncoding)
//            
//            
            
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse!,data: NSData!,error: NSError!)-> Void in
                let imgTmp = UIImage(data: data)
                self.imageCache[imageUrl] = imgTmp
//                self.imageCacheHeight[imageUrl] = imgTmp?.size.height
//                println(self.imageCacheHeight)
                })
            
        }

println(image)
        for tmpHeight in self.imageCacheHeight.values{
        
            self.tmpFloat = tmpHeight
        
        }
        

        return CGSizeMake(300,300)

    }
    
    //点击cell框事件
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        println(indexPath.row)
    }
    
//    func invalidationContextForBoundsChange(newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext{
//                let imgSize = CGSizeMake(500.0, 300.0)
//
//
//                //                    println(ff)
//                let frame = UICollectionViewLayoutInvalidationContext()
//                frame.contentSizeAdjustment = imgSize
//                println(111)
//                return frame
//
//    }
//    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize{
//        
//                let imgSize = CGSizeMake(200.0, 300)
//                collectionView.sizeThatFits(imgSize)
//
////        CGSizeMake(<#width: CGFloat#>, <#height: CGFloat#>)
//
//        return CGSizeMake(150, 150 * 1.4)
//    }
    
    
//    func invalidationContextForPreferredLayoutAttributes(preferredAttributes: UICollectionViewLayoutAttributes, withOriginalAttributes originalAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutInvalidationContext{
//        let imgSize = CGSizeMake(500.0, 300.0)
//        let ff = collectionView.contentSize
//        collectionView.sizeThatFits(imgSize)
//        //                    println(ff)
//        let frame = UICollectionViewLayoutInvalidationContext()
//        frame.contentSizeAdjustment = imgSize
//        println(111)
//        return frame
//        
//    }
    
    func invalidateItemsAtIndexPaths(indexPaths: NSIndexPath){
        println(indexPaths.row)
    }
//    
    //当self-sizing发送变化时,是否更新视图(原布局失效,默认否)
    func shouldInvalidateLayoutForPreferredLayoutAttributes(preferredAttributes: UICollectionViewLayoutAttributes, withOriginalAttributes originalAttributes: UICollectionViewLayoutAttributes) ->Bool{
        return true
    }
    
     func collectionViewContentSize() -> CGSize{
        println(54)
        return CGSizeMake(333, 150 * 1.4)
    }
    
    //cell margin   左右边距
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, insetForSectionAtIndex section: Int) -> UIEdgeInsets{
        return UIEdgeInsetsMake(0, 5, 0, 5);
    }
    
    //点击其他部位隐藏虚拟键盘
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        search.resignFirstResponder()
    }
    
    // 当搜索按钮被点击时调用该方法
    func searchBarSearchButtonClicked(searchBar: UISearchBar){
        //隐藏键盘
        search.resignFirstResponder()
        collectionView.hidden = false
        //开始搜索
//        let url = "http://top.mogujie.com/app_top_v151_login/mobilelogin?_swidth=720&_channel=NAOtopGrey&_atype=android&_sdklevel=18&_network=2&_fs=NAOtopGrey151&_did=99000537220553&_aver=150&_source=NAOtopGrey151"
//        let params = ["uname" : search.text]
//        
//        eHttp.post(url, params: params, callback: {(data: NSDictionary) -> Void in
//            let code = data["status"]?["code"] as NSNumber
//            let msg = data["status"]?["msg"] as String
//        })
        
        let url = "http://top.mogujie.com/top/zadmin/app/yituijian?_adid=99000537220553&sign=qbruUWHlzmGjgRlHAZAsJpzsBr+PsBvAgpG95SIfyD984P69bAHPOQ7Guz78b3etvg2eC+rpQtsJFSpC0K9dIg=="
        eHttp.delegate = self
        eHttp.get(url)
    }
    
    func didRecieveResult(result: NSDictionary) {
        if(result["result"]?["list"] != nil && result["result"]?["isEnd"] as NSNumber != 1){
            self.tmpListData = result["result"]?["list"] as NSMutableArray //list数据
            self.page = result["result"]?["page"] as Int
            self.collectionView.reloadData()
        }
    }
}

