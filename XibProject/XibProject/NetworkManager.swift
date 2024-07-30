//
//  NetworkManager.swift
//  XibProject
//
//  Created by vamsi on 29/07/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case responseError
    case decodingError(Error)
}
final class NetworkManager {
    
    static let shared = NetworkManager()
    
    func fetchData<T: Decodable>(from urlString: String, ofType type: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: urlString) else { return completion(.failure(.invalidURL)) }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                completion(.failure(.requestFailed(error)))
                return
            }
            guard let data else {
                completion(.failure(.responseError))
                return
            }
            guard let response = response as? HTTPURLResponse, 200 ... 299 ~= response.statusCode else {
                completion(.failure(.responseError))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }.resume()
    }
}
