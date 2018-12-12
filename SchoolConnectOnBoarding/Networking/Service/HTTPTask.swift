//
//  HTTPTask.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 4/9/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String:String]

public enum HTTPTask {
    case request
    case requestParameters(bodyParameters: Loopable?, urlParameters: Parameters?)
    case requestParametersAndHeaders(bodyParameters: Loopable?,
        urlParameters: Parameters?,
        additionalHeaders: HTTPHeaders?)
}
