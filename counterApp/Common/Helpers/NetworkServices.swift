//
//  NetworkServices.swift
//  counterApp
//
//  Created by Juan Camilo on 7/12/20.
//

import Foundation

public enum APIServiceError: Error {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case decodeError
}

enum HttpMethod: String {
    case post = "POST"
}

class NetworkServices {
    
    private let urlSession = URLSession.shared
    private var aditionalPath: String = ""
    
    private var baseUrl: URL? {
        var url = URL(string: Configuration.shared.getValueConfiguration(withType: String.self, key: .baseUrl) ?? "")
        if !aditionalPath.isEmpty {
            url?.appendPathComponent(aditionalPath)
        }
        return url
    }
    
    func get<T: Codable>(type: T.Type, aditionalPath: String,
                         completion: @escaping (Result<T, APIServiceError>) -> ()) {
        self.aditionalPath = aditionalPath
        
        guard let url = baseUrl else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        urlSession.dataTask(with: url) { (data, response, error)  in
            guard let data = data, let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            do {
                let values = try JSONDecoder().decode(type, from: data)
                completion(.success(values))
            } catch {
                completion(.failure(.decodeError))
            }
        }.resume()
    }
    
    func createCounter(data: CounterRequest, aditionalPath: String, completion: @escaping (Result<[Counter], APIServiceError>) -> ()) {
        self.aditionalPath = aditionalPath
        
        guard let url = baseUrl else {
            return
        }
        guard let jsonData = try? JSONEncoder().encode(data) else {
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = HttpMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            do {
                let values = try JSONDecoder().decode([Counter].self, from: data)
                completion(.success(values))
            } catch {
                completion(.failure(.decodeError))
            }
        }.resume()
    }
}
