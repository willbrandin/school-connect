//
//  SCHomeLink.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/20/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import Foundation

class SCHomeLink: Codable {
    
    //MARK: - Properties
    let title: String?
    let linkUrl: String?
    let linkId: String?
    let schoolId: String?
    
    //MARK: - Init
    
    enum CodingKeys: String, CodingKey {
        case title, linkUrl
        case linkId = "_id"
        case schoolId = "school"
    }
    
    //MARK: - Methods
    
    static func fetchHomeLinks(with schoolId: String?, update: Bool = true, completion: @escaping (Bool, SCErrors?) -> Void = {_,_  in } ){
        guard let id = schoolId else {
            completion(false, SCErrors.noSchoolId)
            return
        }
        let networkManager = NetworkManager.sharedInstance
        let endpoint = SchoolConnectAPI.homeLinks(id: id)
        
        networkManager.requestWithListResponse(for: endpoint, [SCHomeLink].self) { result in
            switch result {
            case .success(let links):
                guard let returnedLinks = links as? [SCHomeLink] else {
                    completion(false, SCErrors.noSchoolLinks)
                    return
                }
//                saveLinksData(links: returnedLinks, update: update) { isComplete in
//                    if isComplete {
//                        completion(true, nil)
//                    }
//                }
            case .error:
                completion(false, SCErrors.noSchoolLinks)
            }
        }
    }
    
}
