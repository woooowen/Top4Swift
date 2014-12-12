//
//  ViewController.swift
//  Top4Swift
//
//  Created by james on 14-11-18.
//  Copyright (c) 2014年 woowen. All rights reserved.
//

import UIKit

class LoginController: UIViewController,HttpProtocol{
    
    @IBOutlet weak var Uname: UITextField!
    @IBOutlet weak var Pwd: UITextField!
    
    var eHttp: HttpController = HttpController()
    var base: baseClass = baseClass()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //加载LaunchImage之后停止2秒钟,用来显示炫酷launchImage而装x,有的时候的确太长了点.2秒钟好了
        NSThread.sleepForTimeInterval(2)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //点击登录
    @IBAction func LoginBtnClick(sender: AnyObject) {
        let url = "http://top.mogujie.com/app_top_v151_login/mobilelogin?_swidth=720&_channel=NAOtopGrey&_atype=android&_sdklevel=18&_network=2&_fs=NAOtopGrey151&_did=99000537220553&_aver=150&_source=NAOtopGrey151"
        let params = ["mobile" : self.Uname.text , "pwd" : self.Pwd.text]
        eHttp.post(url, params: params, callback: {(data: NSDictionary) -> Void in
            var code = false
            if(data["status"]?["code"] as NSNumber == 1001){
                code = true
            }
            if(code){
                //存储cache
                self.base.cacheSetString("sign", value: data["result"]?["sign"] as String)
                self.performSegueWithIdentifier("login", sender: self)
            }else{
                //app日志
                //错误判断,弹出框错误提示
                let code = data["status"]?["code"] as NSNumber
                let msg = data["status"]?["msg"] as String
                let alert: UIAlertView = UIAlertView(title: "登陆失败", message: msg, delegate: self, cancelButtonTitle: "OK")
                alert.show()
            }
        })
    }
    
    //点击其他部位隐藏虚拟键盘
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        Uname.resignFirstResponder()
        Pwd.resignFirstResponder()
    }
    
    func didRecieveResult(result: NSDictionary) {
        
    }
}

