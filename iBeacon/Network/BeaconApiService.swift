//
//  BeaconApiService.swift
//  iBeacon
//
//  Created by Khalil on 30.10.2019.
//  Copyright © 2019 Khalil Akhmetsafin. All rights reserved.
//

import Foundation
import Alamofire

typealias JSON = [String: Any]

class BeaconApiService {
    
    static let apiUrl = "http://tryourself.ru/"
    
    static func getBeacons(completion: @escaping (MyBeaconsResult?) -> Void){
        let parameters: JSON = [:]
        query(query: "get-beacons", method: .get, parameters: parameters, completion: completion)
    }
    
    static func query<T: Decodable> (query: String, method: HTTPMethod, parameters: JSON, completion: @escaping (T?) -> Void){
        let queryUrl = apiUrl + query
        AF.request(queryUrl, method: method, parameters: parameters).responseJSON { (jsonResponse) in
            if let jsonValue = jsonResponse.value as? JSON {
                if let jsonData = try? JSONSerialization.data(withJSONObject: jsonValue, options: []){
                    let decoder = JSONDecoder()
                    do {
                        let result = try decoder.decode(T.self, from: jsonData)
                        completion(result)
                    } catch {
                        print(error)
                    }
                }
                else {
                    print("error2")
                }
            } else {
                print("error1")
            
            }
        }
    }
}

