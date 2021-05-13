//
//  Error.swift
//  QuizApp
//
//  Created by Luka Namačinski on 13.05.2021..
//

import Foundation

enum RequestError: Error {
    case noInternetError
    case invalidURLError
    case clientError
    case serverError
    case noDataError
    case dataDecodingError
}

extension RequestError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noInternetError:
            return "No Internet connection!"
        case .invalidURLError:
            return "Invalid URL!"
        case .clientError:
            return "Client error!"
        case .serverError:
            return "Server error!"
        case .noDataError:
            return "No data!"
        case .dataDecodingError:
            return "Couldn't decode data!"
        }
    }
}
