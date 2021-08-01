//
//  NetworkService.swift
//  HTrack
//
//  Created by Jedi Tones on 7/10/21.
//

import Foundation

final class NetworkService: NetworkServiceProtocol {
    func createRequest(path: String,
                       httpMethod: HTTPMethod = .get,
                       httpHeaders: [String: String]? = nil,
                       complition: @escaping (Result<URLRequest, NetworkError>) -> Void) {
        
        guard let URL = URL(string: path) else {
            complition(.failure(.incorrectURL))
            return
        }
        var request = URLRequest(url: URL)
        request.httpMethod = httpMethod.rawValue
        
        if let httpHeaders = httpHeaders {
            httpHeaders.forEach { (key, value) in
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        complition(.success(request))
    }
}
