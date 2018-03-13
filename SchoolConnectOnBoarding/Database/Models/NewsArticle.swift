//
//  NewsArticle.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/13/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import Foundation
import Firebase

class NewsArticle {
    
    //MARK: Properties
    var title: String?
    var subtitle: String?
    var source: String?
    var pubDate: String?
    var imgUrl: String?
    var fullStory: String?
    
    //MARK: Inits
    func initWithResponse(_ dataDictionary: NSDictionary){
        self.title = dataDictionary["title"] as? String
        self.subtitle = dataDictionary["subtitle"] as? String
        self.source = dataDictionary["source"] as? String
        self.pubDate = dataDictionary["pubDate"] as? String
        self.fullStory = dataDictionary["story"] as? String
        
        if let imageUrl = dataDictionary["imgUrl"] as? String {
            self.imgUrl = imageUrl
        } else {
            self.imgUrl = SNDatabaseQueryManager.savedSchool()?.appSettings?.defaultImgUrl
        }
    }
    
   
    
    
    //MARK: Methods
    static func downloadNewsData(completion: @escaping ([NewsArticle]) -> Void) {
        var newsItems = [NewsArticle]()
        let ref = Database.database().reference()
        
        guard let id = SNDatabaseQueryManager.savedSchool()?.schoolId else { return }
        
        let newsQuery = ref.child(FirebasePathStrings.newsPath.rawValue).child(id)
        
        newsQuery.observe(.childAdded) { (snapshot) in
            if let data = snapshot.value as? NSDictionary {
                let newStory = NewsArticle()
                newStory.initWithResponse(data)
                newsItems.append(newStory)
                completion(newsItems)
            }
        }
    }
    
    
    
}
