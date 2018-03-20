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
    
    func initWithResponse(_ dataDictionary: NSDictionary){
        self.title = dataDictionary["title"] as? String
        self.linkUrl = dataDictionary["url"] as? String
    }
    
    override open static func primaryKey() -> String? {
        
        return "linkId"
    }
    
    //MARK: - Methods
    static func getHomeLinksForSchool(update: Bool, completion: @escaping (Bool) -> Void = {_ in } ) {
        var linksArray = [SCHomeLink]()
        
//        let realmList = List<SCHomeLink>()
        
        let ref: DatabaseReference!
        ref = Database.database().reference()
        guard let id = SCDatabaseQueryManager.savedSchool()?.schoolId else { return }
        
        let queryPath = ref.child(FirebasePathStrings.homeLinks.rawValue).child(id)
        queryPath.observe(.childAdded) { (snapshot) in
            if let data = snapshot.value as? NSDictionary {
                let newLink = SCHomeLink()
                newLink.initWithResponse(data)
                newLink.linkId = snapshot.key
                linksArray.append(newLink)
                
                DispatchQueue.main.async {
                    autoreleasepool {
                        if update {
                            DatabaseManager.saveRealmArray(linksArray, update: true)

                        } else {
                            DatabaseManager.saveRealmArray(linksArray, update: false)
                            completion(true)

                        }
                    }
                }
                
            }
        }
        
        
    }
    
}
