//
//  ViewController.swift
//  Top4Swift
//
//  Created by james on 14-11-18.
//  Copyright (c) 2014年 woowen. All rights reserved.
//

import UIKit

class normalPool: UIViewController,HttpProtocol,UITableViewDataSource,UITableViewDelegate {
    
    var url = "http://top.mogujie.com/top/zadmin/app/index?sign=Mx3KdFcp1pGbaU4PLk82p9sAON6%2FXfJwJjiKf%2FjNMD8J3YyXyjPQS%2FUUQmMMjduXNoZXMsS6cXMF66wmRMs%2Bsw%3D%3D"

    var eHttp: HttpController = HttpController()
    var listData: NSMutableArray = NSMutableArray()
    var tmpListData: NSMutableArray = NSMutableArray()
    var pager:Int = 1
    var page:NSNumber = 1
    
    var imageCache = Dictionary<String,UIImage>()
    var tid: String = ""

    let cellImage = 1
    let cellLabel1 = 2
    let cellLabel2 = 3
    let cellLabel3 = 4
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //加载table 数据
        eHttp.delegate = self
        eHttp.get(url)
//        self.setupRefresh()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
//        
//        if(self.listData.count == 0){
//            
//            if(self.tmpListData.count != 0){
//                
//                self.listData = self.tmpListData
//            }
//        }
//        return listData.count
    }
//    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
//        
//        var cell: AnyObject? = tableView.dequeueReusableCellWithIdentifier("list", forIndexPath: indexPath)
//        
//        
//        let rowData: NSDictionary = self.listData[indexPath.row] as NSDictionary
//        
//        
//        var img = cell?.viewWithTag(cellImage) as UIImageView
//        
//        img.image = UIImage(named: "default.png")
//        
//        let url = rowData["cover"] as String!
//        
//        if (url != ""){
//            let image = self.imageCache[url] as UIImage?
//            if !(image != nil){
//                let imageUrl:NSURL = NSURL(string:url)!
//                
//                let request: NSURLRequest = NSURLRequest(URL: imageUrl)
//                //异步获取
//                NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse!,data: NSData!,error: NSError!)-> Void in
//                    let imgTmp = UIImage(data: data)
//                    img.image = imgTmp
//                    self.imageCache[url] = imgTmp
//                })
//            }else{
//                img.image = image
//            }
//        }
//        var label1 = cell?.viewWithTag(cellLabel1) as UILabel
//        var label2 = cell?.viewWithTag(cellLabel2) as UILabel
//        var label3 = cell?.viewWithTag(cellLabel3) as UILabel
//        //label换行
//        label1.numberOfLines = 0
//        label1.lineBreakMode = NSLineBreakMode.ByWordWrapping
//        
//        label1.text = rowData["content"]? as NSString
//        label2.text = rowData["user"]?["uname"] as NSString
//        
//        var outputFormat = NSDateFormatter()
//        outputFormat.dateFormat = "yyyy/MM/dd HH:mm:ss"
//        outputFormat.locale = NSLocale(localeIdentifier: "shanghai")
//        //发布时间
//        let pubTime = NSDate(timeIntervalSince1970: rowData["pubTime"] as NSTimeInterval)
//        label3.text = outputFormat.stringFromDate(pubTime)
//        
//        return cell as UITableViewCell
        return
    }
    
    func didRecieveResult(result: NSDictionary){
        
        if (result["result"]?["list"] != nil && result["result"]?["isEnd"] as NSNumber != 1){
            self.tmpListData = result["result"]?["list"] as NSMutableArray  //list主要数据
            self.page = result["result"]?["page"] as NSNumber  //分页显示

        }
        println(self.tmpListData)
    }
}

