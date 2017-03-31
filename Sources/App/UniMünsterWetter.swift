//
//  UniMünster.swift
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

struct UniMünsterWetter{
    

    var data = Dictionary<String, String>()
    init?() {
        
        let curlObject = CURL(url: "http://www.uni-muenster.de/Klima/wetter/wetter.php")
        let curlResult =  curlObject.performFully()
        
        let bytes =  curlResult.2
        guard
        let htmlstring = String(bytes: bytes, encoding: .utf8),
            let doc = HTML(html: htmlstring, encoding: .utf8)
            else {
                return nil
        }
        
        // get all td objects
        let xpath = doc.xpath("//td")
        guard let   temperatur = xpath[6].innerHTML?.trim(),
            let      messzeit = xpath[3].innerHTML?.trim(),
            let      windstärke = xpath[18].innerHTML?.trim(),
            let      wetterbeschreibung = xpath[36].innerHTML?.trim()
            else {
                return nil
        }
        
        
        //DEBUG
//            var i = 0
//            for node in doc.xpath("//td") {
//                print("\(i):  + \(node.text!)")
//                i += 1
//            }
        
        data["temperatur"] = temperatur
        data["messzeit"] = messzeit
        data["windstärke"] = windstärke
        data["wetterbeschreibung"] = wetterbeschreibung

    }
    
   
    
}
extension String
{
func trim() -> String
{
    return self.replacingOccurrences(of: "\n", with: "", options: String.CompareOptions.regularExpression, range: nil)
}
}
