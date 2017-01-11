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
    
    
    init?() {
        
        // Load URL into Kanna
        guard let url = URL(string: "http://weatherpro.consumer.meteogroup.com/weatherpro/WeatherServiceFeed.php?format=xml&lid=18220778&mode=free&uuid=E12A0F7B-5C8E-4860-ABA9-F73C17230F63"),
            let doc = HTML(url:url, encoding: .utf8)
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
                
                print(dateFormatter.date(from: node["dtg"] ?? "" )?.string(format: "EEEE, d. MMM"))
                print(nf.string(for: (Double(node["tn"] ?? "0")?.rounded())))
                print(nf.string(for: (Double(node["tx_n"] ?? "0")?.rounded())))
                print(node["sun"])
                print(node["prrr"])
                print(node["symbol"])

                
                if
                let datum = dateFormatter.date(from: node["dtg"] ?? "" )?.string(format: "EEEE, d. MMM"),
                let tiefsttemperatur = nf.string(for: (Double(node["tn"] ?? "0")?.rounded())),
                let höchsttemperatur = nf.string(for: (Double(node["tx_n"] ?? "0")?.rounded())),
                let sonnenscheindauer = node["sun"],
                let regenwahrscheinlichkeit = node["prrr"],
                let symbol = node["symbol"]
                {
                    alleTageswetter.append(Tageswetter(datum: datum, tiefsttemperatur: tiefsttemperatur, höchsttemperatur: höchsttemperatur, sonnenscheindauer: sonnenscheindauer, regenwahrscheinlichkeit: regenwahrscheinlichkeit, symbol: symbol))
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
