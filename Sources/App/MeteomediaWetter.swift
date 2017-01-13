//
//  Wetteronline.swift
//  muensterwetter
//
//  Created by Krystof Beuermann on 31.12.16.
//
//

import Foundation
import Vapor
import Fluent
import Kanna

struct Tageswetter : NodeConvertible
{
    var datum: String
    var tiefsttemperatur: String
    var höchsttemperatur: String
    var sonnenscheindauer: String
    var regenwahrscheinlichkeit: String
    var symbol: String
    
    init(datum: String,tiefsttemperatur: String,höchsttemperatur: String,sonnenscheindauer: String,regenwahrscheinlichkeit: String, symbol: String)
    {
        self.datum = datum
        self.tiefsttemperatur = tiefsttemperatur
        self.höchsttemperatur = höchsttemperatur
        self.sonnenscheindauer = sonnenscheindauer
        self.regenwahrscheinlichkeit = regenwahrscheinlichkeit
        self.symbol = symbol
    }
    
    
    func makeNode(context: Context) throws -> Node
    {
        let node = try Node(node: ["datum":datum, "tiefsttemperatur":tiefsttemperatur,"höchsttemperatur":höchsttemperatur, "sonnenscheindauer":sonnenscheindauer,"regenwahrscheinlichkeit":regenwahrscheinlichkeit, "symbol":symbol ] )
        return node
    }
    
    init(node: Node, in context: Context) throws
    {
    
         let datum = (node["datum"]?.string) ?? ""
         let tiefsttemperatur = (node["tiefsttemperatur"]?.string) ?? ""
         let höchsttemperatur = (node["höchsttemperatur"]?.string) ?? ""
         let sonnenscheindauer = (node["sonnenscheindauer"]?.string) ?? ""
         let regenwahrscheinlichkeit = (node["regenwahrscheinlichkeit"]?.string) ?? ""
        let  symbol = (node["symbol"]?.string) ?? ""

            self.datum = datum
            self.tiefsttemperatur = tiefsttemperatur
            self.höchsttemperatur = höchsttemperatur
            self.sonnenscheindauer = sonnenscheindauer
            self.regenwahrscheinlichkeit = regenwahrscheinlichkeit
            self.symbol = symbol

        
    }
    
}

final class MeteomediaWetter {
    
        var alleTageswetter = Array<Tageswetter>()
    
    
    init?(drop: Droplet) {
        
        // Load URL into Kanna
        guard
            let bytes: Bytes? = try? drop.client.get("http://weatherpro.consumer.meteogroup.com/weatherpro/WeatherServiceFeed.php?format=xml&lid=18220778&mode=free&uuid=E12A0F7B-5C8E-4860-ABA9-F73C17230F63").body.bytes ,
            let htmlstring = String(bytes: bytes!, encoding: .utf8),
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
        
            for node in doc.xpath("//day") {
                
                
                if
                let datum = dateFormatter.date(from: node["dtg"] ?? "" )?.string(format: "EEEE, d. MMM"),
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
                    alleTageswetter.append(Tageswetter(datum: datum, tiefsttemperatur: tiefsttemperaturFormatted, höchsttemperatur: höchsttemperaturFormatted, sonnenscheindauer: sonnenscheindauer, regenwahrscheinlichkeit: regenwahrscheinlichkeit, symbol: symbol))
                }
                

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
