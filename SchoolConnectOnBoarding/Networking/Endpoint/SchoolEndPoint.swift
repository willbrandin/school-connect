//
//  SchoolEndPoint.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 4/9/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import Foundation

public enum Result<T,U>{
    case success(T)
    case error(U)
}

enum APIError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailure
    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Request Failed"
        case .invalidData: return "Invalid Data"
        case .responseUnsuccessful: return "Response Unsuccessful"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .jsonConversionFailure: return "JSON Conversion Failure"
        }
    }
}


enum NetworkEnvironment {
    case qa
    case production
    case staging
    case development
}

public enum SchoolConnectAPI {
    case configSettings(id: String)
    case news(id: String)
    case calendar(id: String)
    case homeLinks(id: String)
    case schoolDetails(id: String)
    case schoolSearch(search: String)
}

extension SchoolConnectAPI: EndPointType {
    
    var environmentBaseURL: String {
        switch NetworkManager.environment {
        case .production: return "http://localhost:3000/api"
        case .qa: return ""
        case .staging: return ""
        case .development: return "http://10.157.67.4:3000/api"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("base url could not be config")}
        return url
    }
    
    var path: String {
        switch self {
        case .configSettings(let id):
            return "/config/\(id)" //single GET
        case .news(let id):
            return "/news/\(id)" // []
        case .calendar(let id):
            return "/calendar/\(id)" // []
        case .homeLinks(let id):
            return "/homelinks/\(id)" // []
        case .schoolDetails(let id):
            return "/school/\(id)" //single GET
        case .schoolSearch:
            return "/school/list/" // []
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .schoolSearch(let search):
            return .requestParameters(bodyParameters: nil, urlParameters: ["name": search])
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    
}









