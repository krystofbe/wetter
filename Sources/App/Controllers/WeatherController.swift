import Vapor
import HTTP
import Foundation

final class WeatherController {
    
    func addRoutes(drop: Droplet)
    {
        drop.get("vorhersagegrafik.png", handler: vorhersagegrafik)
        drop.get("/", handler: indexView)
    }
    
    func indexView(request: Request) throws -> ResponseRepresentable {
        guard let unimuensterdaten = UniMünsterWetter(drop: drop),
            let alleTageswetter = MeteomediaWetter(drop:drop)?.alleTageswetter
        
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
