
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
            var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
            self.delegate?.didRecieveResult(jsonResult)            
        })
    }
    
    //json post方法
    func post(url: String ,params: NSDictionary){
        

    }
}