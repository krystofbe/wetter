import Vapor
import HTTP
import Solar
import Foundation

final class WeatherController {
    
    func addRoutes(drop: Droplet)
    {
        drop.get("wetter", handler: indexView)
        drop.get("vorhersagegrafik.png", handler: vorhersagegrafik)
    }
    
    func indexView(request: Request) throws -> ResponseRepresentable {
        guard let unimuensterdaten = UniMünsterWetter(),
        let alleTageswetter = MeteomediaWetter()?.alleTageswetter
        else
        {
            throw Abort.serverError
        }
        let sunrisesunset = sunriseSunset()
        let regenradar = Regenradar(drop: drop)
        
        return try drop.view.make("home", Node(node: [
            "unimuensterdaten": Node(node:unimuensterdaten),
            "sunrisesunset": Node(node: [sunrisesunset.0, sunrisesunset.1]),
            "wetteronline": Node(node:alleTageswetter),
            "radarbilder": Node(node:regenradar.radarbilder),
            "unwetterzentrale": Node(node:Unwetterzentrale(drop:drop).alleWarnungen)


        ]))
    }
    
    func sunriseSunset() -> (String, String)
    {
        if let timezone = TimeZone(identifier: "Europe/Paris"),
            let solar = Solar(withTimeZone: timezone,
                              latitude: 51.954,
                              longitude: 7.629),
            let sunrise = solar.sunrise,
            let sunset = solar.sunset
            
           {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            
            return (dateFormatter.string(from: sunrise), dateFormatter.string(from: sunset))
            }
           else{
            return ("N/A","N/A")
            }
    }
    
    func vorhersagegrafik(request: Request) throws -> ResponseRepresentable {
        let response = Response(status: .ok)
        response.headers["Content-Type"] = "image/png"
        
        let spotifyResponse = try drop.client.get("http://wetterstationen.meteomedia.de/messnetz/vorhersagegrafik/103130.png")
        response.body = spotifyResponse.body
        //esponse.body = nil
        return response
    }
   
    
}
