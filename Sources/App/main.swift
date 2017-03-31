import PerfectLib
import PerfectHTTP
import PerfectHTTPServer
import PerfectMustache
import PerfectCURL

// Create HTTP server
let server = HTTPServer()

let handler = {
    (request: HTTPRequest, response: HTTPResponse) in
    
    let webRoot = request.documentRoot
    mustacheRequest(request: request, response: response, handler: WeatherController(), templatePath: webRoot + "/index.mustache")
}

let vorhersageGrafikHandler = {
    (request: HTTPRequest, response: HTTPResponse)  in
    
    response.status = .ok
    response.addHeader(HTTPResponseHeader.Name.contentType, value: "image/png")
    let curlObject = CURL(url: "http://wetterstationen.meteomedia.de/messnetz/vorhersagegrafik/103130.png")
    
    
    let curlResult =  curlObject.performFully()

        response.appendBody(bytes: curlResult.2)   // body
        response.completed()
    

}

// Add our routes
var routes = Routes()
routes.add(method: .get, uri: "/", handler: handler)
routes.add(method: .post, uri: "/", handler: handler)


routes.add(method: .get, uri: "vorhersagegrafik.png", handler: vorhersageGrafikHandler)

server.addRoutes(routes)

// Set the listen port
server.serverPort = 8080

// Set the server's webroot
server.documentRoot = "./Resources/"

do {
    // Launch the server
    try server.start()
} catch PerfectError.networkError(let err, let msg) {
    print("Network error thrown: \(err) \(msg)")
}
