//
//  JsonTests.swift
//  muensterwetter
//
//  Created by Krystof Beuermann on 26.03.17.
//
//

import Foundation
import XCTest
import Jay

class JsonTests: XCTestCase {

    func testJsonDecode()
    {
        let jsonString = "{\"anfang\": [{\"yolo\": [{\"yolo\": 3},{\"mono\": 3}]},{\"mono\": 3}]}"

        do {
            //get data from disk/network
            
            //ask Jay to parse your data
            let jayson = try Jay().jsonFromData(Array(jsonString.utf8))
            //or
            //let json = try Jay().anyJsonFromData(data) // [String: Any] or [Any]
            
            //if it doesn't throw an error, all went well
            if let tasks = jayson.dictionary?["today"]?.array {
                //you have a dictionary root object, with an array under the key "today"
                print(tasks) //["laundry", "cook dinner for gf"]
            } 
        } catch {
            XCTFail()
        }

    }

}
