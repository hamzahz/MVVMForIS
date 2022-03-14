//
//  LoginService.swift
//  MVVMForIS
//
//  Created by Hamza on 3/13/22.
//

import Foundation
import Alamofire

typealias UserDataCompletion = (User?, CustomError?) -> ()

class UserLoginService {
    
    static func getUserLoginAuthToken(userName: String, password: String, completion: @escaping UserDataCompletion) {
        let parameters : [String: Any] = [
            "username": userName,
            "password":password
        ]
        let headers: HTTPHeaders = ["Content-Type":"application/json"]
        
        AF.request(Constant.loginURL, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseDecodable(of: User.self) { response in
            debugPrint(response)
            if response.error != nil {
                completion(nil, CustomError.unexpected(code: response.error?.responseCode ?? 400))
                return
            }
            
            completion(response.value, nil)
        }
    }
}
