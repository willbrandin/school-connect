//
//  SCHomeLink.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/20/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import Foundation
import Firebase
import RealmSwift

class SCHomeLink: Object, Decodable {
    
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
    
    enum CodingKeys: String, CodingKey
    {
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
    
    static func fetchHomeLinks(with schoolId: String?, update: Bool = true, completion: @escaping (Bool, SCErrors?) -> Void){
        guard let id = schoolId else {
            completion(false, SCErrors.noSchoolId)
            return
        }
        let networkManager = NetworkManager.sharedInstance
        let endpoint = SchoolConnectAPI.homeLinks(id: id)
        
        networkManager.getList(for: endpoint, [SCHomeLink].self, completion: {result in
            switch result {
            case .success(let links):
                let returnedLinks = links as! [SCHomeLink]
                saveLinksData(links: returnedLinks, update: false, completion: { (isComplete) in
                    if isComplete {
                        completion(true, nil)
                    }
                })
            case .error:
                completion(false, SCErrors.noSchoolLinks)
                
            }
        })
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
    
    //******Deprecated******//
    @available(*, deprecated)
    static func getHomeLinksForSchool(update: Bool, completion: @escaping (Bool, SCErrors?) -> Void = {_,_  in } ) {
        
        var linksArray = [SCHomeLink]()
    
        let ref: DatabaseReference!
        ref = Database.database().reference()
        guard let id = SCDatabaseQueryManager.savedSchool()?.schoolId else {
            completion(false, SCErrors.noSchoolId)
            return
        }
        
        let queryPath = ref.child(FirebasePathStrings.homeLinks.rawValue)
    
        queryPath.observe(.value) { (snapshot) in
           
            if let data = snapshot.value as? NSDictionary {
                if let linksData = data[id] as? NSDictionary {
                    
                    for dic in linksData {
                        let newLink = SCHomeLink()

                        newLink.initWithResponse(dic.value as? NSDictionary)
                        newLink.linkId = dic.key as? String
                        linksArray.append(newLink)
                    }
                    
                    DispatchQueue.main.async {
                        autoreleasepool {
                            if update {
                                DatabaseManager.saveRealmArray(linksArray, update: true)
                                return
                            } else {
                                DatabaseManager.saveRealmArray(linksArray, update: false)
                                
                                completion(true, nil)
                                return
                            }
                        }
                    }
                }else {
                    completion(true, nil)
                }
            } else {
                completion(false, SCErrors.noSchoolLinks)
            }
        }
    }
}
