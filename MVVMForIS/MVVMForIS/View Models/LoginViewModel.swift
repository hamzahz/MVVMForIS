//
//  LoginViewModel.swift
//  MVVMForIS
//
//  Created by Hamza on 3/13/22.
//

import Foundation

public class LoginViewModel {
    let loading = Box("")
    
    func getAuthentication(userName: String?, password: String?, completion: @escaping UserDataCompletion) {
        self.loading.value = "Loading..."
        
        guard let userName = userName, !userName.isEmpty, let password = password, !password.isEmpty else {
            completion(nil, CustomError.textFieldsEmpty)
            return
        }
        
        UserLoginService.getUserLoginAuthToken(userName: userName, password: password) { [weak self] (user, error) in
            guard let _ = self else { return }
            
            if let user = user {
                let keychain = KeychainHelper()
                keychain.set(user.token, forKey: Constant.userAuthToken)
                completion(user, nil)
                return
            }
            
            if error != nil {
                debugPrint("Error while parsing authentication: \(String(describing: error))")
                completion(nil, error)
                return
            }
            
            
        }
    }
}
