//
//  SchoolEndPoint.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 4/9/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import Foundation

public enum APIError: Error {
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
    case localDev
}

public enum SchoolConnectAPI {
    case configSettings(id: String)
    case news(id: String)
    case calendar(id: String)
    case homeLinks(id: String)
    case schoolDetails(id: String)
    case schoolSearch(search: String)
    case sendMessage(data: Loopable)
}

extension SchoolConnectAPI: EndPointType {
    
    var environmentBaseURL: String {
        switch NetworkManager.environment {
        case .production: return "http://www.schoolconnected.net/api"
        case .qa: return ""
        case .staging: return "http://stg.schoolconnected.net/api"
        case .development: return "http://dev.schoolconnected.net/api"
        case .localDev: return "http://localhost:3000/api"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("base url could not be config") }
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
            return "/school/info/\(id)" //single GET
        case .schoolSearch:
            return "/school/list/" // []
        case .sendMessage:
            return "/message/"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .calendar, .configSettings, .homeLinks, .news, .schoolDetails, .schoolSearch:
            return .get
        case .sendMessage:
            return .post
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .schoolSearch(let search):
            return .requestParameters(bodyParameters: nil, urlParameters: ["name": search])
        case .sendMessage(let data):
            
            return .requestParameters(bodyParameters: data, urlParameters: nil)
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
}
