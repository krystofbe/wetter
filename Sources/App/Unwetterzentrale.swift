//
//  Unwetterzentrale.swift
//  muensterwetter
//
//  Created by Krystof Beuermann on 01.01.17.
//
//
import Foundation
import PerfectLib
import PerfectHTTP
import PerfectHTTPServer
import Kanna
import PerfectCURL


final class Unwetterzentrale {
    
    var ary = [[String:Any]]()

    
    init?() {
        
        
        let curlObject = CURL(url: "http://www.wettergefahren.de/DWD/warnungen/warnapp/warnings.json")
        let curlResult =  curlObject.performFully()
        
        let bytes =  curlResult.2
     
       
        
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM yyyy HH:mm"
        
        
        if  
            let htmlstring = String(bytes: bytes, encoding: .utf8)?.replacingOccurrences(of: "warnWetter.loadWarnings(", with: "").replacingOccurrences(of: ");", with: ""),
            let decoded = try? htmlstring.jsonDecode() as? [String:Any],
            let array = decoded?["warnings"]as? [String: Array<[String:Any]>]
        {
         


            for warnung  in array
            {
                if
                let headline = (warnung.value as? [[String:Any]])?[0]["headline"]as? String,
                    let event = (warnung.value as? [[String:Any]])?[0]["event"]as? String,
                    let description = (warnung.value as? [[String:Any]])?[0]["description"]as? String,
                    let regionName = (warnung.value as? [[String:Any]])?[0]["regionName"]as? String,
                    let start = (warnung.value as? [[String:Any]])?[0]["start"]as? Int,
                    //let end = (warnung.value as? [[String:Any]])?[0]["end"]as? Int,
                    let type = (warnung.value as? [[String:Any]])?[0]["type"]as? Int,
                    let level = (warnung.value as? [[String:Any]])?[0]["level"]as? Int
                    
        
                {
                    if (regionName.contains("Münster"))
                    {
                        let startFormatted = formatter.string(from: Date(timeIntervalSince1970: TimeInterval(start/1000)))
                        //let endFormatted = formatter.string(from: Date(timeIntervalSince1970: TimeInterval(end/1000)))
                        ary.append(["headline": headline, "event": event, "description": description, "start": startFormatted, "end": "", "type": type, "level": level,"regionName": regionName])
                        
                    }
              
                      
                    
                }
            }
        }
    }
    
    
}
