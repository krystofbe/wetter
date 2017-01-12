//
//  Tests.swift
//  muensterwetter
//
//  Created by Krystof Beuermann on 31.12.16.
//
//

import XCTest
import Vapor
class Tests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    
    func testMeteomediaWetter() {
      let model = MeteomediaWetter()
        XCTAssertNotNil(model, "Model darf nicht nil sein")
        XCTAssertTrue(model!.alleTageswetter.count > 0)
    }
    
    
        func testUnwetterzentrale() {
            let drop = Droplet()
            let model = Unwetterzentrale(drop: drop)
            print(model.alleWarnungen)
    
        }
    
    func testUniMünsterWetter() {
        let model = UniMünsterWetter()
        
        XCTAssertNotNil(model)
        XCTAssertNotEqual(model?.wetterbeschreibung,"")
        XCTAssertNotEqual(model?.messzeit,"")
        XCTAssertNotEqual(model?.temperatur,"")
        XCTAssertNotEqual(model?.windstärke,"")

    }
    
//
//    func testRegenradar()
//    {
//        let drop = Droplet()
//        let regenradar = Regenradar(drop: drop)
//        XCTAssert(regenradar.radarbilder.count > 0)
//        for radarbild in regenradar.radarbilder
//        {
//            let url = ("https://mtfm.wetteronline.de/tiles?\(radarbild.hash)&id=\(radarbild.timestamp)&jpg_quality=80&production_line=\(radarbild.productionLine)&s=M0120&size=256&version=\(radarbild.version)&wrextent=europe&x=1024&y=768")
//            if let response = try? drop.client.get(url)
//            {
//                let length = Int(response.headers["Content-Length"]!)
//                if length! < 5000
//                {
//                    print(url)
//                     XCTFail()
//                }
//            }
//            else
//            {
//                XCTFail()
//            }
//           
//        }
//    }

}
