//
//  File.swift
//  muensterwetter
//
//  Created by Krystof Beuermann on 01.01.17.
//
//

//
//  Wetteronline.swift
//  muensterwetter
//
//  Created by Krystof Beuermann on 31.12.16.
//
//

import Foundation
import PerfectLib
import PerfectHTTP
import PerfectHTTPServer
import PerfectCURL

class Regenradar
{


    
    
    var ary = [[String:Any]]()


init?() {
    
    let curlObject = CURL(url: "https://mtfm.wetteronline.de/metadata?&bev=1&wrextent=europe")
    let curlResult =  curlObject.performFully()
    let bytes =  curlResult.2
    
    
    if
        let htmlstring = String(bytes: bytes, encoding: .utf8),
        let decoded = try? htmlstring.jsonDecode() as? [String:Any],
        let array = (decoded?["periods"]as?[String: Any])?["current_15"]as? Array<[String: Any]>
    {
        let MAX_FUTURE = 3
        var futureCounter = 0
        for current_15 in array
        {
            if
                let timestamp = current_15["timestamp"] as? String,
                let designation = current_15["designation"]as? String,
                let query = current_15["query"] as? [String: Any],
                let productionLine = query["production_line"]as? String,
                let version = query["version"]as? String,
                let hash = query["hash"]as? String

            {
            
            if  futureCounter < MAX_FUTURE
            {
                ary.append(["timestamp":timestamp, "productionLine":productionLine,"version":version, "hash":hash])
                
                if (designation == "future")
                {
                    futureCounter+=1
                }
            }
            }
        }
    }
    else
    {return nil}
}
}
