import Vapor
import HTTP
import Foundation

final class WeatherController {
    
    func addRoutes(drop: Droplet)
    {
        drop.get("wetter", handler: indexView)
        drop.get("wetter/vorhersagegrafik.png", handler: vorhersagegrafik)
    }
    
    func indexView(request: Request) throws -> ResponseRepresentable {
        guard let unimuensterdaten = UniMünsterWetter(),
        let alleTageswetter = MeteomediaWetter()?.alleTageswetter
        
        else
        {
            throw Abort.serverError
        }
        
        let regenradar = Regenradar(drop: drop)
        let sunrisesunset = SunriseSunset(drop: drop)
        return try drop.view.make("home", Node(node: [
            "unimuensterdaten": Node(node:unimuensterdaten),
            "sunrisesunset": Node(node: [sunrisesunset.sunrise, sunrisesunset.sunset]),
            "wetteronline": Node(node:alleTageswetter),
            "radarbilder": Node(node:regenradar.radarbilder),
            "unwetterzentrale": Node(node:Unwetterzentrale(drop:drop).alleWarnungen)


        ]))
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
