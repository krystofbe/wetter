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

//    
//    init?() {
//        
//        
//        let curlObject = CURL(url: "https://app-prod-ws.warnwetter.de/v11/warningOverview?points=7.6135%7C51.9507")
//        let curlResult =  curlObject.performFully()
//        
//        let bytes =  curlResult.2
//     
//       
//        
//        let formatter = DateFormatter()
//        formatter.dateFormat = "E, d MMM yyyy HH:mm"
//        
//        
//        if  
//            let htmlstring = String(bytes: bytes, encoding: .utf8),
//            let decoded = try? htmlstring.jsonDecode() as? [String:Any],
//            let array = (decoded?["warnings"]as?[String: Any])?["7.6135|51.9507"]as? Array<[String: Any]>
//        {
//         
//            for warnobjekt in array
//            {
//                if let warnung = warnobjekt.object,
//                    let headline = warnung["headline"]?.string,
//                    let event = warnung["event"]?.string,
//                    let description = warnung["description"]?.string,
//                    let start = warnung["start"]?.int,
//                    let end = warnung["end"]?.int,
//                    let type = warnung["type"]?.string,
//                    let level = warnung["level"]?.string
//                    
//        
//                {
//                    let startFormatted = formatter.string(from: Date(timeIntervalSince1970: TimeInterval(start/1000)))
//                    let endFormatted = formatter.string(from: Date(timeIntervalSince1970: TimeInterval(end/1000)))
//                alleWarnungen.append([headline: headline, event: event, description: description, start: startFormatted, end: endFormatted, type: type, level: level])
//                        
//                      
//                    
//                }
//            }
//        }
//    }
    
    
    //0.1724|45.5341
}
