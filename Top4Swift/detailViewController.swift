//
//  DetailController.swift
//  Topadmin
//
//  Created by james on 14-10-6.
//  Copyright (c) 2014年 woowen. All rights reserved.
//
import UIKit

class detailViewController: UIViewController,UIWebViewDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    
    @IBOutlet weak var loadImg: UIActivityIndicatorView!
    
    @IBOutlet weak var accessBtn: UIButton!
    
    @IBOutlet weak var checkBtn: UIButton!
    
    @IBOutlet weak var offShelfBtn: UIButton!
    
    var timeLineUrl: String = ""
    
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
    //看过按钮点击事件
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
    //看过按钮点击事件
    @IBAction func checkBtnClick(sender: AnyObject) {
        var btnName = checkBtn.titleForState(UIControlState.Normal)
        if(btnName == "看过"){
            checkBtn.setTitle("已看过", forState: UIControlState.Normal)
            checkBtn.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        }else{
            checkBtn.setTitle("看过", forState: UIControlState.Normal)
            checkBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
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