//
//  SCHomeLink.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/20/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import Foundation
import RealmSwift

class SCHomeLink: Object, Codable {
    
    //MARK: - Properties
    @objc dynamic var title: String?
    @objc dynamic var linkUrl: String?
    @objc dynamic var linkId: String?
    @objc dynamic var schoolId: String?
    
    //MARK: - Init
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)!
        linkUrl = try values.decodeIfPresent(String.self, forKey: .linkUrl)!
        linkId = try values.decodeIfPresent(String.self, forKey: .linkId)!
        schoolId = try values.decodeIfPresent(String.self, forKey: .schoolId)!
    }
    
    enum CodingKeys: String, CodingKey {
        case title, linkUrl
        case linkId = "_id"
        case schoolId = "school"
    }
    
    func initWithResponse(_ dataDictionary: NSDictionary?){
        self.title = dataDictionary?["title"] as? String
        self.linkUrl = dataDictionary?["url"] as? String
    }
    
    override open static func primaryKey() -> String? {
        return "linkId"
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
                saveLinksData(links: returnedLinks, update: update) { isComplete in
                    if isComplete {
                        completion(true, nil)
                    }
                }
            case .error:
                completion(false, SCErrors.noSchoolLinks)
            }
        }
    }
    
    private static func saveLinksData(links: [SCHomeLink],update: Bool, completion: @escaping (Bool) -> Void = {_ in } ) {
        DispatchQueue.main.async {
            autoreleasepool {
                if update {
                    DatabaseManager.saveRealmArray(links, update: true)
                    return
                } else {
                    DatabaseManager.saveRealmArray(links, update: false)
                    completion(true)
                    return
                }
            }
        }
    }
    
}
