//
//  NetworkServiceProtocol.swift
//  HTrack
//
//  Created by Jedi Tones on 7/10/21.
//

import Foundation

protocol NetworkServiceProtocol {
    func createRequest(path: String,
                       httpMethod: HTTPMethod,
                       httpHeaders: [String: String]?,
                       complition: @escaping (Result<URLRequest, NetworkError>) -> Void)
    
    func getDecodedDataWithRequest<T:Decodable>(request: URLRequest, complition: @escaping (Result<T, NetworkError>) -> Void)
    func getDataWithURL(url: URL, complition: @escaping (Result<Data, NetworkError>) -> Void)
    func getDataWithRequest(request: URLRequest, complition: @escaping (Result<Data, NetworkError>) -> Void)
}

extension NetworkServiceProtocol {
    private func decodingData<T: Decodable>(request: URLRequest,
                                            decodingType: T.Type?,
                                            complition: @escaping (Result<T, NetworkError>) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let response = response as? HTTPURLResponse else {
                complition(.failure(.requestFail))
                return
            }
            
            
            switch response.statusCode {
            case 200:
                guard let data = data else {
                    complition(.failure(.invalidData))
                    return
                }
                guard let decoding = decodingType else {
                    complition(.failure(.invalidData))
                    return
                }
                do {
                    let entity = try JSONDecoder().decode(decoding, from: data)
                    DispatchQueue.main.async {
                        complition(.success(entity))
                    }
                } catch {
                    complition(.failure(.parsingJSONFail))
                }
                
            case 300:
                complition(.failure(.error300))
            case 400:
                print(response)
                complition(.failure(.error400))
            case 500:
                complition(.failure(.error500))
            default:
                complition(.failure(.unownedError))
                
            }
        }
    }
    
    private func getDataURL(url: URL, complition: @escaping (Result<Data, NetworkError>) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: url){ data, response, error in
            
            guard let response = response as? HTTPURLResponse else {
                complition(.failure(.requestFail))
                return
            }
            
            switch response.statusCode {
            case 200:
                guard let data = data else {
                    complition(.failure(.invalidData))
                    return
                }
                complition(.success(data))
            case 300:
                complition(.failure(.error300))
            case 400:
                print(response)
                complition(.failure(.error400))
            case 500:
                complition(.failure(.error500))
            default:
                complition(.failure(.unownedError))
                
            }
        }
    }
    
    private func getDataRequest(request: URLRequest, complition: @escaping (Result<Data, NetworkError>) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let response = response as? HTTPURLResponse else {
                complition(.failure(.requestFail))
                return
            }
            
            switch response.statusCode {
            case 200:
                guard let data = data else {
                    complition(.failure(.invalidData))
                    return
                }
                complition(.success(data))
            case 300:
                complition(.failure(.error300))
            case 400:
                print(response)
                complition(.failure(.error400))
                
            case 500:
                complition(.failure(.error500))
            default:
                complition(.failure(.unownedError))
                
            }
        }
    }
    
    func getDecodedDataWithRequest<T:Decodable>(request: URLRequest, complition: @escaping (Result<T, NetworkError>) -> Void) {
        decodingData(request: request,
                     decodingType: T.self,
                     complition: complition).resume()
    }
    
    func getDataWithURL(url: URL, complition: @escaping (Result<Data, NetworkError>) -> Void) {
        getDataURL(url: url,
                complition: complition).resume()
    }
    
    func getDataWithRequest(request: URLRequest, complition: @escaping (Result<Data, NetworkError>) -> Void) {
        getDataRequest(request: request,
                complition: complition).resume()
    }
}

