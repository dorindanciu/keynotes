//
//  ClientTests.swift
//  ClientTests
//
//  Created by rocky on 2/5/17.
//  Copyright © 2017 DorinDanciu. All rights reserved.
//

import XCTest
@testable import Client

enum Host: String {
    case local = "http://0.0.0.0:8080"
    case macMini = "http://192.168.1.9:8080"
}

class ClientTests: XCTestCase {

    var start: UInt = 0
    var limit: UInt = 0

    override func setUp() {
        super.setUp()
        start = 0
        limit = 100
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testLocalHostJSONPerformance() {
        self.measureMetrics(XCTestCase.defaultPerformanceMetrics(), automaticallyStartMeasuring: false) {
            // Define expectation to allow asynchronous testing
            let expect = self.expectation(description: Date().description)

            // Begin measuring
            self.startMeasuring()

            // Code to test
            self.requestBeers(.local, start: self.start, limit: self.limit, responseType: .json) { payloadSize in

                // End measurement
                self.stopMeasuring()

                // Stop waiting
                expect.fulfill()

//                print(payloadSize)
            }

            self.waitForExpectations(timeout: 60, handler: nil)
        }
    }

    func testLocalHostProtoPerformance() {
        self.measureMetrics(XCTestCase.defaultPerformanceMetrics(), automaticallyStartMeasuring: false) {
            // Define expectation to allow asynchronous testing
            let expect = self.expectation(description: Date().description)

            // Begin measuring
            self.startMeasuring()

            // Code to test
            self.requestBeers(.local, start: self.start, limit: self.limit, responseType: .octetStream) { payloadSize in

                // End measurement
                self.stopMeasuring()

                // Stop waiting
                expect.fulfill()

//                print(payloadSize)
            }
            
            self.waitForExpectations(timeout: 60, handler: nil)
        }
    }

    func requestBeers(_ host: Host, start: UInt, limit: UInt , responseType: ResponseType, completion: @escaping (_ payloadSize: Int) -> ())  {
        let url = URL(string: "\(host.rawValue)/beers?start=\(start)&limit=\(limit)")
        var request = URLRequest(url: url!)
        request.setValue(responseType.rawValue, forHTTPHeaderField: "Accept")

        let operation = NetworkOperation()
        operation.request = request
        operation.responseHandler = { data in
            do {
                switch responseType {
                case .json:
                    let jsonString = String.init(data: data, encoding: .utf8)!
                    _ = try BeerList(json: jsonString)
                default:
                    _ = try BeerList(protobuf: data)
                }

                completion(data.count)
            } catch let error {
                print("You can huff and puff, but it failed like this: \(error)")
            }
        }

        operation.start()
    }
}
