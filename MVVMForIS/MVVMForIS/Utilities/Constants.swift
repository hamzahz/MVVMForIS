//
//  Constants.swift
//  MVVMForIS
//
//  Created by Hamza on 3/13/22.
//

import Foundation
import UIKit

struct Constant {
    static let userAuthToken = "userAuthToken"
    static let loginURL = "http://94.206.102.22/app/authenticate"
    static let itemListURL = "http://94.206.102.22/app/item-list"
    
    static func showAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alert
    }
}
