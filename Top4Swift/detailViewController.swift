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
    
    var timeLineUrl: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        timeLineUrl = "http://top.mogujie.com/top/share/note?tid=" + timeLineUrl
        println(self.timeLineUrl)
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
    
}