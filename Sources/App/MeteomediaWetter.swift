
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
import Kanna
import PerfectCURL

 struct MeteomediaWetter {
    
    var ary = [[String:Any]]()


    init?() {
        
        // Load URL into Kanna
        
        let curlObject = CURL(url: "http://weatherpro.consumer.meteogroup.com/weatherpro/WeatherServiceFeed.php?format=xml&lid=18220778&mode=free&uuid=E12A0F7B-5C8E-4860-ABA9-F73C17230F63")
        let curlResult =  curlObject.performFully()
        
        let bytes =  curlResult.2
        guard
            let htmlstring = String(bytes: bytes, encoding: .utf8),
            let doc = HTML(html: htmlstring, encoding: .utf8)
            else {
                return nil
        }
        
      
        
               //DEBUG
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        
        let nf = NumberFormatter()
        nf.numberStyle = NumberFormatter.Style.decimal
        nf.maximumFractionDigits = 0
        var count = 0
        
            for node in doc.xpath("//day") {
                var cssClass = ""
                
                if (count > 3)
                {
                    cssClass = "hidden-xs"
                }
                
                if (count > 4)
                {
                    break
                }
                
                if
                let datum = dateFormatter.date(from: node["dtg"] ?? "" )?.string(format: "EEEE"),
                let tiefsttemperatur =  node["tn"] as String?,
                let höchsttemperatur = node["tx_n"] as String?,
                    let tiefsttemperaturNumber =  Double(tiefsttemperatur),
                    let höchsttemperaturNumber = Double(höchsttemperatur),
                let sonnenscheindauer = node["sun"],
                let regenwahrscheinlichkeit = node["prrr"],
                let symbol = node["symbol"]
                {
                    let tiefsttemperaturFormatted = String(format:"%.0f", tiefsttemperaturNumber)
                    let höchsttemperaturFormatted = String(format:"%.0f", höchsttemperaturNumber)
                    
                    ary.append([
                        "datum":datum,
                        "tiefsttemperatur":tiefsttemperaturFormatted,
                        "höchsttemperatur":höchsttemperaturFormatted,
                        "sonnenscheindauer":sonnenscheindauer,
                        "regenwahrscheinlichkeit":regenwahrscheinlichkeit,
                        "symbol":symbol,
                        "cssClass":cssClass
                        ])
                }
                count+=1
                
                
        }

    }
 
   
    
}

extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
