//
//  NetworkService.swift
//  QuizApp
//
//  Created by Luka Namačinski on 12.05.2021..
//

import Foundation

class NetworkService {

    private static var currentUser: User!
    
    private func executeURLRequest<T: Decodable>(_ request: URLRequest,
                                                 completionHandler: @escaping (Result<T, RequestError>) -> Void) {
        
        // TODO: No Internet connection
        
        URLSession.shared.dataTask(with: request) {
            (data, response, error) -> Void in
            
            guard error == nil else {
                completionHandler(.failure(.clientError))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completionHandler(.failure(.serverError))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.noDataError))
                return
            }
            
            guard let value = try? JSONDecoder().decode(T.self, from: data) else {
                // Pretty clunky but I couldn't think of another way to parse empty success responses
                // TODO: Fix empty responses
                guard data.isEmpty else {
                    completionHandler(.success(data as! T))
                    return
                }
                completionHandler(.failure(.dataDecodingError))
                return
            }
            
            completionHandler(.success(value))
        }.resume()
    }
    
    private func executeURLRequest<T: Decodable>(route: Router,
                                                 completionHandler: @escaping (Result<T, RequestError>) -> Void) {
        var components = URLComponents()
        components.scheme = route.scheme
        components.host = route.host
        components.path = route.path
        components.queryItems = route.queryItems
        
        guard let url = components.url else {
            completionHandler(.failure(.invalidURLError))
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = route.method
        urlRequest.httpBody = route.body
        if let headers = route.headers {
            for header in headers {
                urlRequest.setValue(header.value, forHTTPHeaderField: header.key)
            }
        }
        
        executeURLRequest(urlRequest, completionHandler: completionHandler)
    }
    
}

extension NetworkService: NetworkServiceProtocol {
    
    func login(username: String, password: String, completionHandler: @escaping (Result<User, RequestError>) -> Void) {
        let loginRoute = Router.login(username: username, password: password)
        executeURLRequest(route: loginRoute, completionHandler: completionHandler)
    }
    
    func fetchQuizes(completionHandler: @escaping (Result<QuizCollection, RequestError>) -> Void) {
        let getQuizzesRoute = Router.getQuizzes
        executeURLRequest(route: getQuizzesRoute, completionHandler: completionHandler)
    }
    
    func postQuizResult(quizResult result: QuizResult,
                        completionHandler: @escaping (Result<Data, RequestError>) -> Void) {
        let postResultRoute = Router.postQuizResult(result: result)
        executeURLRequest(route: postResultRoute, completionHandler: completionHandler)
    }
    
    func fetchLeaderboard(forQuizID id: Int,
                          completionHander: @escaping (Result<[LeaderboardResult], RequestError>) -> Void) {
        let fetchLeaderboardRoute = Router.getLeaderboard(id: id)
        executeURLRequest(route: fetchLeaderboardRoute, completionHandler: completionHander)
    }
}

