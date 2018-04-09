//
//  SCNetworkManager.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 4/6/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import Foundation
import RealmSwift

typealias WBApiRequestBuilder = (url: String, action: WBHttpMethods)
typealias WBApiRequestParams = [String:String]
fileprivate let baseURL = "http://localhost:3000/api"

enum WBHttpMethods: String {
    case get = "GET"
    case post = "POST"
}





enum SCDataObjects {
    //Takes in id
    case appConfig
    case schoolInfo
    
    func builder() -> WBApiRequestBuilder {
        switch self {
        case .appConfig:
            return (baseURL + "/config/\(12341234)", WBHttpMethods.get)
        case .schoolInfo:
            return (baseURL + "/school/info/\(1312341234)", WBHttpMethods.get)
        }
    }
    
}


protocol APIClient {
    var session: URLSession { get }
    func fetch<T: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIError>) -> Void)
}

extension APIClient {
    
    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void
    
    private func decodingTask<T: Decodable>(with request: URLRequest, decodingType: T.Type, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
        
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed)
                return
            }
    
            if httpResponse.statusCode == 200 {
                if let data = data {
                    do {
                        let genericModel = try JSONDecoder().decode(decodingType, from: data)
                        completion(genericModel, nil)
                    } catch {
                        completion(nil, .jsonConversionFailure)
                    }
                } else {
                    completion(nil, .invalidData)
                }
            } else {
                completion(nil, .responseUnsuccessful)
            }
        }
        return task
    }
    
    func fetch<T: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIError>) -> Void) {
        let task = decodingTask(with: request, decodingType: T.self) { (json , error) in
            
            //MARK: change to main queue
            DispatchQueue.main.async {
                guard let json = json else {
                    if let error = error {
                        completion(Result.error(error))
                    } else {
                        completion(Result.error(.invalidData))
                    }
                    return
                }
                if let value = decode(json) {
                    completion(.success(value))
                } else {
                    completion(.error(.jsonParsingFailure))
                }
            }
        }
        task.resume()
        
    }
}


class SchoolDataClient: APIClient {
    
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init(){
        self.init(configuration: .default)
    }
    
    func get(_ objectType: SCDataObjects, with params: WBApiRequestParams? = nil, completion: @escaping (Result<SNAppSettings?, APIError>) -> Void) {
        
        var request: URLRequest
        
        let builder = objectType.builder()
        
        if let param = params {
            guard let routeRequest = router(builder: builder, params: param) else { return }
            request = routeRequest
        } else {
            guard let routeRequest = router(builder: builder, params: nil) else { return }
            request = routeRequest
        }
        
        fetch(with: request, decode: { json -> SNAppSettings? in
            guard let settings = json as? SNAppSettings else { return nil }
            return settings
        }, completion: completion)
    }
    
    
    private func router(builder: WBApiRequestBuilder, params: WBApiRequestParams?) -> URLRequest? {
        
        var components = URLComponents(string: builder.url)!
        let queryItems = params?.map{
            return URLQueryItem(name: "\($0)", value: "\($1)")
        }
        components.queryItems = queryItems
        
        guard let url = components.url else { return nil }
        return URLRequest(url: url)
    }
    
    
}



//********************************************//


/*
 
protocol Gettable {
    associatedtype T
    
    func get(for type: SCDataObjects, completion: @escaping (Result<T>) -> Void)
}

protocol DataCallable: Decodable {
    
}

struct AppConfigService: Gettable {
    
    
    typealias T = Decodable

    func get(for type: SCDataObjects, completion: @escaping (Result<AppConfigService.T>) -> Void) {
        // Class/Method: create a method to make URL
        //http://10.157.67.220/api/config/5ab9473ac69dc53472dd3c8b
        let jsonURLString = "http://localhost:3000/api/config/5ab9473ac69dc53472dd3c8b"
        guard let url = URL(string: jsonURLString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else { return }
            switch type {
            case .appConfig:
                let appConfig = decodeData(for: SNAppSettings.self, with: data)
                completion(Result.success(appConfig))
            }
            
        }.resume()

    }
    
    func decodeData<T>(for: T, with data: Data) -> T? where T: Decodable{
        do {
            let calledData = try JSONDecoder().decode(T.self, from: data)
            return calledData
        } catch {
            print("ERROR")
        }
        return nil
    }
}
 
*/
