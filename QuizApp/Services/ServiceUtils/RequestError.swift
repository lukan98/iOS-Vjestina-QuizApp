//
//  Error.swift
//  QuizApp
//
//  Created by Luka Namačinski on 13.05.2021..
//

import Foundation

enum RequestError: Error {
    case networkError
    case invalidURLError
    case clientError
    case serverError
    case noDataError
    case dataDecodingError
    case accessForbiddenError
    case unauthorizedError
    case notFoundError
    case badRequestError
}

extension RequestError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .networkError:
            return "Please check your network connection!"
        case .invalidURLError:
            return "Invalid URL!"
        case .clientError:
            return "A client-side error has occured"
        case .serverError:
            return "An internal server error has occured"
        case .noDataError:
            return "No data could be retrieved"
        case .dataDecodingError:
            return "Couldn't read fetched data"
        default:
            return "An error has occured"
        }
    }
}

extension NetworkService {
    
    func handleErrorCode(_ statusCode: Int) -> RequestError {
        switch statusCode {
        case 400:
            return .badRequestError
        case 401:
            return .unauthorizedError
        case 403:
            return .accessForbiddenError
        case 404:
            return .notFoundError
        default:
            return .clientError
        }
    }
    
}
