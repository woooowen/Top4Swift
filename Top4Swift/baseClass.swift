//
//  info.swift
//  Top4Swift
//
//  Created by james on 14-12-10.
//  Copyright (c) 2014年 woowen. All rights reserved.
//

import Foundation
//工具类,放置一些经常用到的方法
//通过userDefault存储数据
class baseClass{
    
    func cacheSetString(key: String,value: String){
        var userInfo = NSUserDefaults()
        userInfo.setValue(value, forKey: key)
    }
    
    func cacheGetString(key: String) -> String{
        var userInfo = NSUserDefaults()
        var tmpSign = userInfo.stringForKey(key)
        return tmpSign!
    }

}