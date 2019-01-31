//
//  SchoolConnectApi.swift
//  SchoolConnectOnBoarding
//
//  Created by Will Brandin on 1/26/19.
//  Copyright © 2019 William Brandin. All rights reserved.
//

import Foundation
import RocketNetworking

struct NetworkManager {
    static let sharedInstance = RocketNetworkManager<SchoolConnectAPI>()
    
    static func setEnvironment(for environment: NetworkEnvironment) {
        NetworkManager.sharedInstance.setupNetworkLayer(in: environment)
    }
}

public enum SchoolConnectAPI {
    case configSettings(id: String)
    case news(id: String)
    case calendar(id: String)
    case homeLinks(id: String)
    case schoolDetails(id: String)
    case schoolSearch(search: String)
    case sendMessage(data: ContactForm)
}

extension SchoolConnectAPI: EndPointType {
    
    public var environmentBaseURL: String {
        switch NetworkManager.sharedInstance.environment {
        case .production: return "http://www.schoolconnected.net/api"
        case .qa: return ""
        case .staging: return "http://stg.schoolconnected.net/api"
        case .development: return "http://dev.schoolconnected.net/api"
        }
    }
    
    public var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("base url could not be config") }
        return url
    }
    
    public var path: String {
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
    
    public var httpMethod: HTTPMethod {
        switch self {
        case .calendar, .configSettings, .homeLinks, .news, .schoolDetails, .schoolSearch:
            return .get
        case .sendMessage:
            return .post
        }
    }
    
    public var task: HTTPTask {
        switch self {
        case .schoolSearch(let search):
            return .requestParameters(bodyParameters: nil, urlParameters: ["name": search])
        case .sendMessage(let data):
            return .requestParameters(bodyParameters: data, urlParameters: nil)
        default:
            return .request
        }
    }
    
    public var headers: HTTPHeaders? {
        return nil
    }
}
