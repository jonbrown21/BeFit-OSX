//
//  CustomError.swift
//  BeFit
//
//  Created by Andrej Slegl on 11/6/19.
//

import Foundation

enum CustomError: LocalizedError {
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .unknown:
            return "Oops, something went wrong..."
        }
    }
}
