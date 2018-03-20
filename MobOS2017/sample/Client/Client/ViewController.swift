//
//  ViewController.swift
//  Client
//
//  Created by rocky on 2/5/17.
//  Copyright © 2017 DorinDanciu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let operationQueue = OperationQueue()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

//        let url = URL(string: "http://0.0.0.0:8080/beers?start=0&limit=20")
//        var request = URLRequest(url: url!)
//        let acceptType = ResponseType.json
//        request.setValue(acceptType.rawValue, forHTTPHeaderField: "Accept")
//
//        let operation = NetworkOperation()
//        operation.request = request
//        operation.responseHandler = { data in
//            do {
//                let list: BeerList
//                switch acceptType {
//                case .json:
//                    let jsonString = String.init(data: data, encoding: .utf8)!
//                    list = try BeerList(json: jsonString)
//                default:
//                    list = try BeerList(protobuf: data)
//                }
//
//                print(list)
//            } catch let error {
//                print("You can huff and puff, but it failed like this: \(error)")
//            }
//        }
//
//        operationQueue.addOperation(operation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

