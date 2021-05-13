//
//  NetworkService.swift
//  QuizApp
//
//  Created by Luka Namačinski on 12.05.2021..
//

import Foundation

class NetworkService {
    
    private func executeURLRequest<T: Decodable>(_ request: URLRequest,
                                                 completionHandler: @escaping (Result<T, RequestError>) -> Void) {
        URLSession.shared.dataTask(with: request) {
            (data, response, error) -> Void in
            
            guard error != nil else {
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
                completionHandler(.failure(.dataDecodingError))
                return
            }
            
            completionHandler(.success(value))
        }.resume()
    }
    
    private func executeURLRequest<T: Decodable>(router: Router,
                                         completionHandler: @escaping (Result<T, RequestError>) -> Void) {
        var components = URLComponents()
        components.scheme = router.scheme
        components.host = router.host
        components.path = router.path
        components.queryItems = router.queryItems
        
        guard let url = components.url else {
            completionHandler(.failure(.invalidURLError))
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = router.method
        
        executeURLRequest(urlRequest, completionHandler: completionHandler)
    }
    
}

extension NetworkService: NetworkServiceProtocol {
    
    func login(email: String, password: String) -> LoginStatus {
        let loginRoute: Router = .login(username: email, password: password)
        executeURLRequest(router: loginRoute, completionHandler: {
            (result: Result<User, RequestError>) -> (Void) in
            switch result {
            case .failure(let error):
                print(error.errorDescription!)
            case .success(let value):
                print(value)
            }
        })
        return LoginStatus.error(400, "Something")
    }
    
    func fetchQuizes() -> [Quiz] {
        return []
    }
    
    func getNoOfQuizCategories() -> (Int) {
        return 0
    }
    
    func getRandomFunFactWord() -> (String) {
        return "A"
    }
    
    func getLeaderboard(forQuizID id: Int) -> [LeaderboardResult] {
        return []
    }
}

