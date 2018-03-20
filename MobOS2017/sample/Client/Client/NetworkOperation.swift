//
//  NetworkOperation.swift
//  Client
//
//  Created by rocky on 2/5/17.
//  Copyright © 2017 DorinDanciu. All rights reserved.
//

import Foundation

final class NetworkOperation: Operation {
    var session: URLSession {
        return URLSession(configuration: config, delegate: self, delegateQueue: nil)
    }
    var config: URLSessionConfiguration {
        return URLSessionConfiguration.default
    }
    var request: URLRequest?
    var responseHandler: ((_ data: Data) -> ())?

    fileprivate(set) var sessionTask: URLSessionTask?
    fileprivate var incomingData = Data()

    private var _isFinished: Bool = true
    override var isFinished: Bool {
        get {
            return _isFinished
        }
        set (newAnswer) {
            willChangeValue(forKey: "isFinished")
            _isFinished = newAnswer
            didChangeValue(forKey: "isFinished")
        }
    }

    override func start() {
        if isCancelled {
            isFinished = true
            return
        }
        guard let request = request else { fatalError("Failed to start without URL request") }

        // cancel ongoing task
        sessionTask?.cancel()

        // launch new task
        sessionTask = session.dataTask(with: request)
        sessionTask!.resume()
    }

    override func cancel() {
        sessionTask?.cancel()
    }
}

extension NetworkOperation: URLSessionDataDelegate {
    func urlSession(_ session: URLSession,
                    dataTask: URLSessionDataTask,
                    didReceive response: URLResponse,
                    completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        if isCancelled {
            isFinished = true
            sessionTask?.cancel()
            return
        }

        completionHandler(.allow)
    }

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        if isCancelled {
            isFinished = true
            sessionTask?.cancel()
            return
        }
        incomingData.append(data)
    }


    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if isCancelled {
            isFinished = true
            sessionTask?.cancel()
            return
        }

        if error != nil {
            print("Network operation failed: \(error)")
            isFinished = true
            return
        }
        responseHandler?(incomingData)
        isFinished = true
    }
}
