//
//  UniMünster.swift
//  muensterwetter
//
//  Created by Krystof Beuermann on 31.12.16.
//
//

import Foundation
import Vapor
import Fluent
import Kanna

final class UniMünsterWetter: Model {
    

    var id: Node?
    var temperatur: String
    var messzeit: String
    var windstärke: String
    var wetterbeschreibung: String
    
    init?() {
        
        // Load URL into Kanna
        guard let url = URL(string: "http://www.uni-muenster.de/Klima/wetter/wetter.php"),
            let doc = HTML(url:url, encoding: .utf8)
            else {
                return nil
        }
        
        // get all td objects
        let xpath = doc.xpath("//td")
        guard let   temperatur = xpath[6].text?.trim(),
            let      messzeit = xpath[3].text?.trim(),
            let      windstärke = xpath[18].text?.trim(),
            let      wetterbeschreibung = xpath[36].text?.trim()
            else {
                return nil
        }
        
        
        //DEBUG
        //    var i = 0
        //    for node in doc.xpath("//td") {
        //        print("\(i):  + \(node.text!)")
        //        i += 1
        //    }
        
        self.temperatur = temperatur
        self.messzeit = messzeit
        self.windstärke = windstärke
        self.wetterbeschreibung = wetterbeschreibung
    }
    
    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        temperatur = try node.extract("temperatur")
        messzeit = try node.extract("messzeit")
        windstärke = try node.extract("windstärke")
        wetterbeschreibung = try node.extract("wetterbeschreibung")

    }
    
    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "id": id,
            "temperatur": temperatur,
            "messzeit": messzeit,
            "windstärke": windstärke,
            "wetterbeschreibungame": wetterbeschreibung
            ])
    }
    
    static func prepare(_ database: Database) throws {}
    
    static func revert(_ database: Database) throws {}
    
}
