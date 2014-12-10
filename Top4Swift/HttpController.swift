
import Foundation

protocol HttpProtocol{
    func didRecieveResult(result: NSDictionary)
}
class HttpController: NSObject{
    
    var delegate: HttpProtocol?
    
    //json get方法
    func get(url: String){
        var nsUrl: NSURL = NSURL(string: url)!
        var request: NSURLRequest = NSURLRequest(URL: nsUrl)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse!,data: NSData!,error: NSError!)->Void in
            if(error == nil){
                var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
                self.delegate?.didRecieveResult(jsonResult)
            }else{
                println(error)
            }
        })
    }    
    //json post方法
    func post(url: String ,params: NSDictionary,callback: (NSDictionary) -> Void) {
        var nsUrl: NSURL = NSURL(string: url)!
        var request: NSMutableURLRequest = NSMutableURLRequest(URL: nsUrl)
        
        request.HTTPMethod = "POST"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        var objStr = ""
        for(key, value) in params as NSDictionary{
            if(objStr == ""){
                objStr += "\(key)=\(value)"
            }else{
                objStr += "&\(key)=\(value)"
            }
        }
        let data: NSData = objStr.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
        request.HTTPBody = data
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse!,data: NSData!,error: NSError!)->Void in
            if(error == nil){
                var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
                self.delegate?.didRecieveResult(jsonResult)
                callback(jsonResult)
            }else{
                println(error)
            }
        })
    }
}