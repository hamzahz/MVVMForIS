//
//  CustomError.swift
//  MVVMForIS
//
//  Created by Hamza on 3/14/22.
//

import Foundation

enum CustomError: Error {
    // Throw when an invalid JSON parse
    case invalidJSON
    
    //TextFields empty
    case textFieldsEmpty

    // Throw in all other cases
    case unexpected(code: Int)
}

extension CustomError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .invalidJSON:
            return "The provided JSON is not valid."
        case .textFieldsEmpty:
            return "Textfields cannot be empty."
        case .unexpected(_):
            return "An unexpected error occurred."
        }
    }
}

extension CustomError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidJSON:
            return NSLocalizedString(
                "The provided JSON is not valid.",
                comment: "Invalid JSON"
            )
        case .textFieldsEmpty:
            return NSLocalizedString(
                "Textfields cannot be empty",
                comment: "Invalid Data"
            )
        case .unexpected(_):
            return NSLocalizedString(
                "An unexpected error occurred.",
                comment: "Unexpected Error"
            )
        }
    }
}
