import Vapor


let drop = Droplet()

let controller = WeatherController()
controller.addRoutes(drop: drop)

drop.run()

