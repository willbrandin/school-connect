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
    
    func initWithResponse(_ dataDictionary: NSDictionary){
        self.title = dataDictionary["title"] as? String
        self.linkUrl = dataDictionary["url"] as? String
    }
    
    //MARK: - Methods
    static func getHomeLinksForSchool(completion: @escaping (Bool) -> Void = {_ in } ) {
        let ref: DatabaseReference!
        ref = Database.database().reference()
        guard let id = SCDatabaseQueryManager.savedSchool()?.schoolId else { return }
        let queryPath = ref.child(FirebasePathStrings.homeLinks.rawValue).child(id)
        
    }
    
}
