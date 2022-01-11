//
//  WebServices.swift
//  CoffeeOrderNewMVVM
//
//  Created by shree on 11/01/22.
//

import Foundation
enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

enum NetworkError: Error{
    case domainError
    case urlError
    case decodingError
}

struct Resources<T: Codable> {
    let url: URL
    var method: HttpMethod = .get
    var data: Data? = nil
}

class webServices {
    func loadOrder<T>(resources: Resources<T>, completion: @escaping(Result<T, NetworkError>)->()){
        var request = URLRequest(url: resources.url)
        request.httpBody = resources.data
        request.httpMethod = resources.method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { (data, responses, error) in
            guard let safeData = data, error == nil else{ completion(.failure(.domainError))
                fatalError()
            }
            let encodedData = try? JSONDecoder().decode(T.self, from: safeData)
            if let safeEncodedData = encodedData{
                completion(.success(safeEncodedData))
            }else{
                completion(.failure(.decodingError))
            }
            
        }.resume()
    }
}
