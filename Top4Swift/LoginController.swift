//
//  ViewController.swift
//  Top4Swift
//
//  Created by james on 14-11-18.
//  Copyright (c) 2014年 woowen. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    @IBOutlet weak var Uname: UITextField!
    @IBOutlet weak var Pwd: UITextField!
    
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
        let url = "http://top.mogujie.com/app_top_v142_login/mobilelogin?_swidth=720&_channel=NAOtop&_atype=android&_sdklevel=18&_network=2&_fs=NAOtop142&_did=99000537220553&_aver=142&_source=NAOtop142"
        //println(Uname.text)
        
        //self.performSegueWithIdentifier("login", sender: self)
    }
    
    //点击其他部位隐藏虚拟键盘
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        Uname.resignFirstResponder()
        Pwd.resignFirstResponder()
    }
    
}

