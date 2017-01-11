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
import Vapor
import Fluent

class Regenradar
{

    struct RegenradarBild : NodeConvertible
    {
        var timestamp: String
        var productionLine: String
        var version: String
        var hash: String

        
        init(timestamp: String,productionLine: String, version: String, hash: String)
        {
            self.timestamp = timestamp
            self.productionLine = productionLine
            self.version = version
            self.hash = hash

        }
        
        
        func makeNode(context: Context) throws -> Node
        {
            let node = try Node(node: ["timestamp":timestamp, "productionLine":productionLine, "version":version, "hash": hash ] )
            return node
        }
        
        init(node: Node, in context: Context) throws
        {
            
            let timestamp = (node["timestamp"]?.string) ?? ""
            let productionLine = (node["productionLine"]?.string) ?? ""
            let version = (node["version"]?.string) ?? ""
            let hash = (node["hash"]?.string) ?? ""


            
            self.timestamp = timestamp
            self.productionLine = productionLine
            self.version = version
            self.hash = hash

            
        }
        
    }
    
    
var radarbilder = Array<RegenradarBild>()


init(drop: Droplet) {
    if let request = try? drop.client.get("https://mtfm.wetteronline.de/metadata?&bev=1&wrextent=europe"),
        let periods = request.json!["periods", "current_15"],
        let array = periods.array
    {
        let MAX_FUTURE = 3
        var futureCounter = 0
        for current_15 in array
        {
            if let period = current_15.object,
                let timestamp = period["timestamp"]?.string,
                let designation = period["designation"]?.string,
                let query = period["query"]?.object,
                let productionLine = query["production_line"]?.string,
                let version = query["version"]?.string,
                let hash = query["hash"]?.string

            {
            
            if  futureCounter < MAX_FUTURE
            {
                radarbilder.append(RegenradarBild(timestamp: timestamp, productionLine: productionLine,version: version, hash: hash))
                
                if (designation == "future")
                {
                    futureCounter+=1
                }
            }
            }
        }
    }
}
}
