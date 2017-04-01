



import PerfectHTTP
import PerfectMustache

// Handler class
// When referenced in a mustache template, this class will be instantiated to handle the request
// and provide a set of values which will be used to complete the template.
struct WeatherController: MustachePageHandler { // all template handlers must inherit from PageHandler
    
//
//    let regenradar = Regenradar(drop: drop)
//    let sunrisesunset = SunriseSunset(drop: drop)
//    return try drop.view.make("home", Node(node: [
//    "unimuensterdaten": Node(node:unimuensterdaten),
//    "sunrisesunset": Node(node: [sunrisesunset.sunrise, sunrisesunset.sunset]),
//    "wetteronline": Node(node:alleTageswetter),
//    "radarbilder": Node(node:regenradar.radarbilder),
//    "unwetterzentrale": Node(node:Unwetterzentrale(drop:drop).alleWarnungen)
//    
//    
//    ]))
    
    func extendValuesForResponse(context contxt: MustacheWebEvaluationContext, collector: MustacheEvaluationOutputCollector) {
      
        var values = MustacheEvaluationContext.MapType()

        let unims = UniMünsterWetter()
        let meteomedia = MeteomediaWetter()
        let sunrisesunset = SunriseSunset()
        let regenradar = Regenradar()
        let unwetter = Unwetterzentrale()

        values["unimuensterdaten"] = unims?.data
        values["meteomedia"] = meteomedia?.ary
        values["sunrisesunset"] = sunrisesunset?.data
        values["regenradar"] = regenradar?.ary
        values["unwetter"] = unwetter?.ary

        contxt.extendValues(with: values)
        do {
            try contxt.requestCompleted(withCollector: collector)
        } catch {
            let response = contxt.webResponse
            response.status = .internalServerError
            response.appendBody(string: "\(error)")
            response.completed()
        }
    }
}
