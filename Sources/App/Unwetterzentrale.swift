//
//  Unwetterzentrale.swift
//  muensterwetter
//
//  Created by Krystof Beuermann on 01.01.17.
//
//
import Foundation
import Vapor
import Fluent
import Kanna

struct Wetterwarnung : NodeConvertible
{
    var headline: String
    var event: String
    var description: String
    var start: String
    var end: String
    var type: String
    var level: String
    
    init(headline: String,event: String,description: String,start: String,end: String,type: String, level: String)
    {
        self.headline = headline
        self.event = event
        self.description = description
        self.start = start
        self.end = end
        self.type = type
        self.level = level
    }
    
    
    func makeNode(context: Context) throws -> Node
    {
        let node = try Node(node: ["headline":headline, "event":event,"description":description, "start":start,"end":end, "type":type,"level":level ] )
        return node
    }
    
    init(node: Node, in context: Context) throws
    {
        
        let headline = (node["headline"]?.string) ?? ""
        let event = (node["event"]?.string) ?? ""
        let description = (node["description"]?.string) ?? ""
        let start = (node["start"]?.string) ?? ""
        let end = (node["end"]?.string) ?? ""
        let  type = (node["type"]?.string) ?? ""
        let  level = (node["level"]?.string) ?? ""
        
        self.headline = headline
        self.event = event
        self.description = description
        self.start = start
        self.end = end
        self.type = type
        self.level = level
        
        
    }
    
}

final class Unwetterzentrale {
    
    var alleWarnungen = Array<Wetterwarnung>()

    
    init(drop: Droplet) {
        
     
        // Verdammte Kunststückchen hier weil fucking Vapor die HTTP Nachricht hier nicht passt.
       let url = URL(string: "https://app-prod-ws.warnwetter.de/v11/warningOverview?points=7.6135%7C51.9507")
       
        
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM yyyy HH:mm"
        
        
        if  let doc = try? Data(contentsOf: url!),
            let request = try? drop.client.get("http://www.proxy-service.de/proxy-service.php?u=http%3A%2F%2Fapp-prod-ws.warnwetter.de%2Fv11%2FwarningOverview%3Fpoints%3D7.6135%257C51.9507&b=0&f=norefer"),
            let json = request.json,
            let periods = json["warnings", "7.6135|51.9507"],
            let array = periods.array
        {
         
            for warnobjekt in array
            {
                if let warnung = warnobjekt.object,
                    let headline = warnung["headline"]?.string,
                    let event = warnung["event"]?.string,
                    let description = warnung["description"]?.string,
                    let start = warnung["start"]?.int,
                    let end = warnung["end"]?.int,
                    let type = warnung["type"]?.string,
                    let level = warnung["level"]?.string
                    
        
                {
                    let startFormatted = formatter.string(from: Date(timeIntervalSince1970: TimeInterval(start/1000)))
                    let endFormatted = formatter.string(from: Date(timeIntervalSince1970: TimeInterval(end/1000)))
                alleWarnungen.append(Wetterwarnung(headline: headline, event: event, description: description, start: startFormatted, end: endFormatted, type: type, level: level))
                        
                      
                    
                }
            }
        }
    }
    
    
    
}
