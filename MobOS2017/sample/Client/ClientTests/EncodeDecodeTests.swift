//
//  EncodeDecodeTests.swift
//  Client
//
//  Created by rocky on 2/7/17.
//  Copyright © 2017 DorinDanciu. All rights reserved.
//

import XCTest
@testable import Client

class EncodeDecodeTests: XCTestCase {
    var start: Int = 0
    var limit: Int = 0
    var allBeers = [Beer]()
    var slice = [Beer]()
    var jsonBeerData = ""
    var protoBeerData = Data()

    override func setUp() {
        super.setUp()

        start = 0
        limit = 100

        if let path = Bundle.main.path(forResource: "beer", ofType: "json") {
            do {
                allBeers = try loadBeers(path)
                let slice: ArraySlice<Beer> = allBeers[start..<(start + limit)]
                self.slice = Array(slice)

                var list = BeerList()
                list.beers = self.slice
                jsonBeerData = try list.serializeJSON()
                protoBeerData = try list.serializeProtobuf()

            } catch let error {
                print(error)
            }
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }


    func loadBeers(_ path: String) throws -> [Beer] {
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [[String: Any]]

        var beers = try jsonResult.map({ try Beer(dictionary:  $0)}) // 22
        beers.append(contentsOf: beers) // 44
        beers.append(contentsOf: beers) // 88
        beers.append(contentsOf: beers) // 176
        
        return beers
    }
    
    func testJSONDecodePerformance() {
        self.measure {
            do {
                _ = try BeerList(json: self.jsonBeerData)
            } catch let error {
                print(error)
            }
        }
    }

    func testProtoDecodePerformance() {
        self.measure {
            do {
                _ = try BeerList(protobuf: self.protoBeerData)
            } catch let error {
                print(error)
            }
        }
    }

    func testJSONEncodePerformance() {
        self.measure {
            do {
                var list = BeerList()
                list.beers = self.slice
                _ = try list.serializeJSON()
            } catch let error {
                print(error)
            }
        }
    }

    func testProtoEncodePerformance() {
        self.measure {
            do {
                var list = BeerList()
                list.beers = self.slice
                _ = try list.serializeProtobuf()
            } catch let error {
                print(error)
            }
        }
    }
}
