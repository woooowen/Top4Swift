//
//  ViewController.swift
//  SwiftSideMenu
//
//  Created by Evgeny on 03.08.14.
//  Copyright (c) 2014 Evgeny Nazarov. All rights reserved.
//

import UIKit

class searchViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,HttpProtocol{
    
    var eHttp = HttpController()
    var tmpListData: NSMutableArray = NSMutableArray()
    var listData: NSMutableArray = NSMutableArray()
    var page = 1 //page
    var imageCache = Dictionary<String,UIImage>()
    var tid: String = ""
    
    let timeLineUrl = "http://top.mogujie.com/top/zadmin/app/yituijian?_adid=99000537220553&sign=qbruUWHlzmGjgRlHAZAsJpzsBr+PsBvAgpG95SIfyD984P69bAHPOQ7Guz78b3etvg2eC+rpQtsJFSpC0K9dIg=="
    
    let cellLabelUname = 1
    let cellImg = 2
    let refreshControl = UIRefreshControl()

    @IBOutlet weak var search: UISearchBar!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //Refresh func
    func setupRefresh(){
        self.collectionView.addHeaderWithCallback({
            let delayInSeconds:Int64 =  1000000000  * 2
            var popTime:dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW,delayInSeconds)
            dispatch_after(popTime, dispatch_get_main_queue(), {
                self.collectionView.reloadData()
                self.collectionView.headerEndRefreshing()
            })
        })
        
        self.collectionView.addFooterWithCallback({
            var nextPage = String(self.page + 1)
            var tmpTimeLineUrl = self.timeLineUrl + "&page=" + nextPage as NSString
            self.eHttp.delegate = self
            self.eHttp.get(tmpTimeLineUrl)
            let delayInSeconds:Int64 = 1000000000 * 2
            var popTime:dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW,delayInSeconds)
            dispatch_after(popTime, dispatch_get_main_queue(), {
                self.collectionView.footerEndRefreshing()
                if(self.tmpListData != self.listData){
                    if(self.tmpListData.count != 0){
                        var tmpListDataCount = self.tmpListData.count
                        for(var i:Int = 0; i < tmpListDataCount; i++){
                            self.listData.addObject(self.tmpListData[i])
                        }
                    }
                    self.collectionView.reloadData()
                    self.tmpListData.removeAllObjects()
                }
            })
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //初始化collectionView
        collectionView.hidden = true
        self.setupRefresh()
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
                })
            }else{
                img.image = image
            }
        }
        
        //标题
        search.backgroundColor = UIColor.whiteColor()
        var label1 = cell.viewWithTag(cellLabelUname) as UILabel
        label1.text = rowData["user"]?["uname"] as NSString

        collectionView.backgroundColor = UIColor.whiteColor()
        
        return cell
    }
    
    //点击cell框事件
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        let trueData: NSDictionary = self.listData[indexPath.row] as NSDictionary
        self.tid = trueData["tid"] as NSString
        self.performSegueWithIdentifier("detail", sender: self)
    }
    
    //跳转传参方法
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detail" {
            var instance = segue.destinationViewController as detailViewController
            instance.tid = self.tid
        }
    }
    
    //cell margin   左右边距
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, insetForSectionAtIndex section: Int) -> UIEdgeInsets{
        return UIEdgeInsetsMake(5, 5, 0, 5);
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
        //开始搜索 由于没有搜索接口,所以使用get方式替代吧.接口近期加上
//        let params = ["uname" : search.text]
//        
//        eHttp.post(url, params: params, callback: {(data: NSDictionary) -> Void in
//            let code = data["status"]?["code"] as NSNumber
//            let msg = data["status"]?["msg"] as String
//        })
        
        eHttp.delegate = self
        eHttp.get(self.timeLineUrl)
    }
    
    func didRecieveResult(result: NSDictionary) {
        if(result["result"]?["list"] != nil && result["result"]?["isEnd"] as NSNumber != 1){
            self.tmpListData = result["result"]?["list"] as NSMutableArray //list数据
            self.page = result["result"]?["page"] as Int
            self.collectionView.reloadData()
        }
    }
}

