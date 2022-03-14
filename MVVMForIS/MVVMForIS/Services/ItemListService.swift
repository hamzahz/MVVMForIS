//
//  ItemListService.swift
//  MVVMForIS
//
//  Created by Hamza on 3/14/22.
//

import Foundation
import Alamofire

typealias ItemListDataCompletion = ([[String: AnyObject]]?, CustomError?) -> ()

class ItemListService {
    
    static func fetchItemList(completion: @escaping ItemListDataCompletion) {
        let headers: HTTPHeaders = ["Content-Type":"application/json",
                                    "Authorization": "Bearer \(KeychainHelper().get(Constant.userAuthToken) ?? "")"]
        
        AF.request(Constant.itemListURL, method: .post, encoding: JSONEncoding.default, headers: headers).response { response in
            do {
                guard let jsonObject = try JSONSerialization.jsonObject(with: response.data!) as? [String: Any] else {
                    print("Error: Cannot convert data to JSON object")
                    completion(nil, CustomError.invalidJSON)
                    return
                }
                guard let itemsJsonArray = jsonObject["itemList"] as? [[String: AnyObject]] else {
                    completion(nil, CustomError.unexpected(code: 400))
                    return
                }
                
                completion(itemsJsonArray, nil)
                
            } catch {
                print("Error: Trying to convert JSON data to string")
                completion(nil, CustomError.unexpected(code: 400))
                return
            }
        }
    }
}
