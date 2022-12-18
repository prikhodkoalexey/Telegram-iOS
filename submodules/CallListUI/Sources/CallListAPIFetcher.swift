//
//  CallListAPIFetcher.swift
//  _idx_CallListUI_ACBFD9F3_ios_min11.0
//
//  Created by Aleksei Prikhodko on 18.12.2022.
//

import Foundation
import SwiftSignalKit

class CallListAPIFetcher {
    static let urlSession = URLSession(configuration: .default)
    static var dataTask: URLSessionDataTask?
    
    static func getCurrentUnitXime() -> Signal<Int32, NoError> {
        return Signal { subscriber in
            dataTask?.cancel()
            
            guard let url = URL(string: "http://worldtimeapi.org/api/timezone/Europe/Moscow") else {
                return EmptyDisposable
            }
            
            dataTask = urlSession.dataTask(with: url) { data, response, error in
                defer { dataTask = nil }
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(httpStatus)")
                }
                
                if let data = data,
                   let httpStatus = response as? HTTPURLResponse,
                   httpStatus.statusCode == 200 {
                    let responseDictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    DispatchQueue.main.async {
                        guard let unixTime = responseDictionary?["unixtime"] as? Int32 else {
                            return
                        }
                        subscriber.putNext(unixTime)
                    }
                }
            }
            
            dataTask?.resume()
            return EmptyDisposable
        }
    }
}
