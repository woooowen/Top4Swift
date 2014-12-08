//
//  DetailController.swift
//  Topadmin
//
//  Created by james on 14-10-6.
//  Copyright (c) 2014年 woowen. All rights reserved.
//
import UIKit

class detailViewController: UIViewController,UIWebViewDelegate,HttpProtocol {
    
    @IBOutlet weak var webView: UIWebView!
    
    @IBOutlet weak var loadImg: UIActivityIndicatorView!
    
    @IBOutlet weak var accessBtn: UIButton!
    
    @IBOutlet weak var checkBtn: UIButton!
    
    @IBOutlet weak var offShelfBtn: UIButton!
    
    var timeLineUrl: String = ""
    
    var eHttp: HttpController = HttpController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        timeLineUrl = "http://top.mogujie.com/top/share/note?tid=" + timeLineUrl
        var url = NSURL(string: self.timeLineUrl)
        var request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //页面加载前
    func webViewDidStartLoad(webView: UIWebView){
        loadImg.startAnimating()
    }
    
    //页面加载完成
    func webViewDidFinishLoad(webView: UIWebView){
        loadImg.stopAnimating()
        loadImg.removeFromSuperview()
    }
    //通过按钮点击事件
    @IBAction func accessBtnClick(sender: AnyObject) {
        var btnName = accessBtn.titleForState(UIControlState.Normal)
        if(btnName == "通过"){
            accessBtn.setTitle("已通过", forState: UIControlState.Normal)
            accessBtn.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        }else{
            accessBtn.setTitle("通过", forState: UIControlState.Normal)
            accessBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        }
    }
    //json 数据处理
    func didRecieveResult(result: NSDictionary){

    }

    //看过按钮点击事件
    @IBAction func checkBtnClick(sender: AnyObject) {
        var btnName = checkBtn.titleForState(UIControlState.Normal)
        if(btnName == "看过"){
            //post 请求api,并且给api传递参数,根据返回值来判断动作执行
            let url = "http://top.mogujie.com/top/zadmin/app/check?sign=MIoTSY7txEI7opexh1Co/gIWRTNYMYpC2Q39CSheb1fJQ5/fB3UKOUSeqJOV0PhT+Oshj9xngY2kCKJVYiNVJw==&_adid=99000537220553"
            let params = ["twitterId" : "13sik"]
            eHttp.delegate = self
            eHttp.post(url, params: params,callback: {(data: NSDictionary) -> Void in
                var tt = false
                if(data["status"]?["code"] as NSNumber == 1001){
                    tt = true
                }
                if(tt){
                    self.checkBtn.setTitle("已看过", forState: UIControlState.Normal)
                    self.checkBtn.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
                }
            })
        }
    }
    //下架按钮点击事件
    @IBAction func offShelfBtnClick(sender: AnyObject) {
        var btnName = offShelfBtn.titleForState(UIControlState.Normal)
        if(btnName == "下架"){
            offShelfBtn.setTitle("已下架", forState: UIControlState.Normal)
            offShelfBtn.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        }else{
            offShelfBtn.setTitle("下架", forState: UIControlState.Normal)
            offShelfBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        }
    }
    
}