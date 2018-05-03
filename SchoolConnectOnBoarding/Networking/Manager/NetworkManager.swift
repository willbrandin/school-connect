//
//  NetworkManager.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 4/9/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import Foundation

struct NetworkManager {
    
    static let sharedInstance = NetworkManager()
    
    static let environment: NetworkEnvironment = .development
    private let router = Router<SchoolConnectAPI>()
    
    
    enum NetworkResponse: String {
        case success
        case authenticationError
        case badRequest
        case outdated
        case failed
        case noData
        case unableToDecode
    }
    
    
    enum NetworkResponseResult<String> {
        case success
        case failure
    }
    
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> NetworkResponseResult<String>{
        switch response.statusCode {
        case 200...299: return .success
        default: return .failure
        }
    }
    
    /**
     Submits a GET request for the specified endpoint provided.
     Request should send back a JSON object which can be decoded to the decodingType provided.
     - important:
     DecodingType must conform to Decodable
     
     - parameters:
        - apiEndpoint: Endpoint of the request.
        - decodingType: The type to decode. ie. School or SCHomeLink
        - completion: The Result enum allows for a switch statement to be used when the method is called.
     */
    func get<T:Decodable>(for apiEndpoint: SchoolConnectAPI, _ decodingType: T.Type, completion: @escaping(Result<Decodable?, APIError>) ->()){
        //gets data based on url...
        router.request(apiEndpoint) { data, response, error in
            if error != nil {
                completion(.error(.requestFailed))
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(.error(.invalidData))
                        return
                    }
                    do {
                        //Decodes the data
                        let apiResonse = try JSONDecoder().decode(decodingType, from: responseData)
                        print("********************************************\n\(apiResonse)\n********************************************")
                        completion(.success(apiResonse))
                    } catch {
                        completion(.error(.jsonParsingFailure))
                    }
                    
                case .failure:
                    completion(.error(.responseUnsuccessful))
                }
            }
            
        }
    }
    /**
     Submits a GET request for the specified endpoint provided.
     Request should send back a list of JSON objects which can be decoded to the decodingType provided.
     - important:
     DecodingType must be [Decodable]
     
     - parameters:
        - apiEndpoint: Endpoint of the request.
        - decodingType: The type to decode. ie. School or SCHomeLink
        - completion: The Result enum allows for a switch statement to be used when the method is called.
    */
    func getList<T:Decodable>(for apiEndpoint: SchoolConnectAPI, _ decodingType: [T].Type, completion: @escaping(Result<[Decodable]?, APIError>) ->()){
        //gets data based on url...
        router.request(apiEndpoint) { data, response, error in
            if error != nil {
                completion(.error(.requestFailed))
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(.error(.invalidData))
                        return
                    }
                    do {
                        //Decodes the data
                        let apiResonse = try JSONDecoder().decode(decodingType, from: responseData)
                        print("********************************************\n\(apiResonse)\n********************************************")
                        completion(.success(apiResonse))
                    } catch {
                        completion(.error(.jsonParsingFailure))
                    }
                    
                case .failure:
                    completion(.error(.responseUnsuccessful))
                }
            }
            
        }
    }
    
    /**
     Submits a POST request for the specified endpoint provided.
     
     - important:
     DecodingType must be [Decodable]
     
     - parameters:
     - apiEndpoint: Endpoint of the request.
     - decodingType: The type to decode. ie. School or SCHomeLink
     - completion: The Result enum allows for a switch statement to be used when the method is called.
     */
    func post<T:Encodable>(for apiEndpoint: SchoolConnectAPI, _ encoding: T.Type, completion: @escaping(Result<String?, APIError>) ->()){
        
        router.request(apiEndpoint) { data, response, error in
            if error != nil {
                completion(.error(.requestFailed))
            }
            
            if let response = response as? HTTPURLResponse {
                
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    if let respData = data, let utf8Representation = String(data: respData, encoding: .utf8) {
                        print("********************************************\n\(utf8Representation)\n********************************************")
                        completion(.success(utf8Representation))
                    } else {
                        print("no readable data received in response")
                        completion(.error(.jsonParsingFailure))
                    }
                case .failure:
                    completion(.error(.responseUnsuccessful))
                }
            }
        }
    }
    
}












