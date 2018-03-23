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

class SCHomeLink: Object {
    
    //MARK: - Properties
    @objc dynamic var title: String?
    @objc dynamic var linkUrl: String?
    @objc dynamic var linkId: String?
    
    func initWithResponse(_ dataDictionary: NSDictionary?){
        self.title = dataDictionary?["title"] as? String
        self.linkUrl = dataDictionary?["url"] as? String
    }
    
    override open static func primaryKey() -> String? {
        
        return "linkId"
    }
    
    //MARK: - Methods
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
                    completion(false, SCErrors.noSchoolLinks)
                }
            } else {
                completion(false, SCErrors.noSchoolLinks)
            }
        }
    }
}
