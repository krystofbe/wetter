//
//  SunriseSunset.swift
//  muensterwetter
//
//  Created by Krystof Beuermann on 08.01.17.
//
//

import Foundation
import Vapor
import Fluent
import Kanna



final class SunriseSunset {
    
    var sunrise: String?
    var sunset: String?
    
    
    init(drop: Droplet) {
        
        
        // Verdammte Kunststückchen hier weil fucking Vapor die HTTP Nachricht hier nicht passt.
        
        
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        
        
        if
            let response = try? drop.client.get("http://api.sunrise-sunset.org/json?lat=51.954&lng=7.629&formatted=0"),
            let sunrise = response.json?["results","sunrise"]?.string,
            let sunset = response.json?["results", "sunset"]?.string,
             let sunrisedatum = formatter.date(from: sunrise )?.string(format: "H:mm"),
             let sunsetdatum = formatter.date(from: sunset)?.string(format: "H:mm")
        {

              self.sunrise = sunrisedatum
            self.sunset = sunsetdatum
        }
    }
    
    
    
}
