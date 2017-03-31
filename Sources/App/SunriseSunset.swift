//
//  SunriseSunset.swift
//  muensterwetter
//
//  Created by Krystof Beuermann on 08.01.17.
//
//

import Foundation
import PerfectLib
import PerfectHTTP
import PerfectHTTPServer
import PerfectCURL
import Kanna



final class SunriseSunset {
    
    var data = Dictionary<String, String>()

    
    init?() {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
                
        let curlObject = CURL(url: "http://api.sunrise-sunset.org/json?lat=51.954&lng=7.629&formatted=0")
        let curlResult =  curlObject.performFully()
        
        let bytes =  curlResult.2
        guard
            let htmlstring = String(bytes: bytes, encoding: .utf8),
            let decoded = try? htmlstring.jsonDecode() as? [String:Any],
            let sunrise = (decoded?["results"]as?[String: Any])?["sunrise"]as? String,
            let sunset = (decoded?["results"] as? [String: Any])?["sunset"] as? String,
            let sunrisedatum = formatter.date(from: sunrise )?.string(format: "H:mm"),
            let sunsetdatum = formatter.date(from: sunset)?.string(format: "H:mm")

            else {
                return nil
        }
        
        data["sunrise"] = sunrisedatum
        data["sunset"] = sunsetdatum
        
  
    }
    
    
    
}
