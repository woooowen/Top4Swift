//
//  ViewController.swift
//  Top4Swift
//
//  Created by james on 14-11-18.
//  Copyright (c) 2014年 woowen. All rights reserved.
//

import UIKit

class normalPoolViewController: UIViewController,HttpProtocol,UITableViewDataSource,UITableViewDelegate {
    
    var timeLineUrl = "http://top.mogujie.com/top/zadmin/app/index?sign=Mx3KdFcp1pGbaU4PLk82p9sAON6%2FXfJwJjiKf%2FjNMD8J3YyXyjPQS%2FUUQmMMjduXNoZXMsS6cXMF66wmRMs%2Bsw%3D%3D"
    
    @IBOutlet weak var tableView: UITableView!
        
    var eHttp: HttpController = HttpController()
    var tmpListData: NSMutableArray = NSMutableArray()
    var listData: NSMutableArray = NSMutableArray()
    var page = 1 //page
    var imageCache = Dictionary<String,UIImage>()
    
    let cellImg = 1
    let cellLbl1 = 2
    let cellLbl2 = 3
    let cellLbl3 = 4
    
    let refreshControl = UIRefreshControl()
    
    //Refresh func
    func setupRefresh(){
        self.tableView.addHeaderWithCallback({
            let delayInSeconds:Int64 =  1000000000  * 2
            var popTime:dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW,delayInSeconds)
            dispatch_after(popTime, dispatch_get_main_queue(), {
                self.tableView.reloadData()
                self.tableView.headerEndRefreshing()
            })
        })
        
        self.tableView.addFooterWithCallback({
            var nextPage = String(self.page + 1)
            var tmpTimeLineUrl = self.timeLineUrl + "&page=" + nextPage as NSString
            self.eHttp.delegate = self
            self.eHttp.get(tmpTimeLineUrl)
            let delayInSeconds:Int64 = 1000000000 * 2
            var popTime:dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW,delayInSeconds)
            dispatch_after(popTime, dispatch_get_main_queue(), {
                self.tableView.footerEndRefreshing()
                if(self.tmpListData != self.listData){
                    if(self.tmpListData.count != 0){
                        var tmpListDataCount = self.tmpListData.count
                        for(var i:Int = 0; i < tmpListDataCount; i++){
                            self.listData.addObject(self.tmpListData[i])
                        }
                    }
                    self.tableView.reloadData()
                    self.tmpListData.removeAllObjects()
                }
            })
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        eHttp.delegate = self
        eHttp.get(self.timeLineUrl)
        self.setupRefresh()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if(self.listData.count == 0){
            
            if(self.tmpListData.count != 0){
                
                self.listData = self.tmpListData
            }
        }
        return listData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var cell: AnyObject? = tableView.dequeueReusableCellWithIdentifier("list", forIndexPath: indexPath)
        let rowData: NSDictionary = self.listData[indexPath.row] as NSDictionary
        let imgUrl = rowData["cover"] as String
        var img = cell?.viewWithTag(cellImg) as UIImageView
        img.image = UIImage(named: "default.png")
        
        if(imgUrl != ""){
            let image = self.imageCache[imgUrl] as UIImage?
            if(image != ""){
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
        var label1 = cell?.viewWithTag(cellLbl1) as UILabel
        //换行
        label1.numberOfLines = 0
        label1.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label1.text = rowData["content"] as NSString
        
        var label2 = cell?.viewWithTag(cellLbl2) as UILabel
        label2.text = rowData["content"] as NSString
        
        var label3 = cell?.viewWithTag(cellLbl3) as UILabel
        //时间格式转换
        var outputFormat = NSDateFormatter()
        outputFormat.dateFormat = "yyyy/MM/dd HH:mm:ss"
        outputFormat.locale = NSLocale(localeIdentifier: "shanghai")
        //发布时间
        let pubTime = NSDate(timeIntervalSince1970: rowData["pubTime"] as NSTimeInterval)
        label3.text = outputFormat.stringFromDate(pubTime)
        
        return cell as UITableViewCell
        
    }
    
    func didRecieveResult(result: NSDictionary){

        if(result["result"]?["list"] != nil && result["result"]?["isEnd"] as NSNumber != 1){
            self.tmpListData = result["result"]?["list"] as NSMutableArray //list数据
            self.page = result["result"]?["page"] as Int
            self.tableView.reloadData()
        }
    }
}

