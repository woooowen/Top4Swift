//
//  ViewController.swift
//  Top4Swift
//
//  Created by james on 14-11-18.
//  Copyright (c) 2014年 woowen. All rights reserved.
//

import UIKit
protocol LoginInfoProtocol{
    //协议-用来存储登陆之后返回的用户信息,方便每个view调用
    func getLoginInfo(sign: String)
}

class LoginController: UIViewController,HttpProtocol{
    
    @IBOutlet weak var Uname: UITextField!
    @IBOutlet weak var Pwd: UITextField!
    
    var loginDelegate: LoginInfoProtocol?
    var eHttp: HttpController = HttpController()
    var sign: String = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                self.sign = data["result"]?["sign"] as String
                println(self.sign)
                self.loginDelegate?.getLoginInfo(self.sign)
                self.performSegueWithIdentifier("login", sender: self)
            }else{
                println(data)
            }
            
        })
    }

//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        //如果登陆成功进行跳转
//        if segue.identifier == "login"{
////            var instance = segue.destinationViewController as tabBarViewController
////            instance.sign = self.sign
//        }
//    }
    
    //点击其他部位隐藏虚拟键盘
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        Uname.resignFirstResponder()
        Pwd.resignFirstResponder()
    }
    
    func didRecieveResult(result: NSDictionary) {
        
    }
    
}

