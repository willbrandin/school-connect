//
//  NewsArticle.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/13/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import Foundation
import Firebase

class NewsArticle: Decodable {
    
    //MARK: Properties
    var title: String?
    var subtitle: String?
    //var source: String?
    var pubDate: String?
    var imgUrl: String?
    var fullStory: String?
    var schoolId: String?
    
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)!
        subtitle = try values.decodeIfPresent(String.self, forKey: .subtitle)!
        //source = try values.decodeIfPresent(String.self, forKey: .source)!
        pubDate = try values.decodeIfPresent(String.self, forKey: .pubDate)!
        imgUrl = try values.decodeIfPresent(String.self, forKey: .imgUrl)!
        fullStory = try values.decodeIfPresent(String.self, forKey: .fullStory)!
        schoolId = try values.decodeIfPresent(String.self, forKey: .schoolId)!
    }
    
    enum CodingKeys: String, CodingKey
    {
        case title, subtitle, pubDate, imgUrl
        case fullStory = "story"
        case schoolId = "school"
    }
    
    //MARK: Inits
    func initWithResponse(_ dataDictionary: NSDictionary){
        self.title = dataDictionary["title"] as? String
        self.subtitle = dataDictionary["subtitle"] as? String
        //self.source = dataDictionary["source"] as? String
        self.pubDate = dataDictionary["pubDate"] as? String
        self.fullStory = dataDictionary["story"] as? String
        
        if let imageUrl = dataDictionary["imgUrl"] as? String {
            self.imgUrl = imageUrl
        } else {
            //self.imgUrl = SCDatabaseQueryManager.savedSchool()?.appSettings?.defaultImgUrl
        }
    }
    
   
    
    
    //MARK: Methods
    
    //TODO: - Limit the number of news items to 10? Then load again when they hit the bottom of the list.
    static func downloadNewsData(completion: @escaping ([NewsArticle]) -> Void) {
        var newsItems = [NewsArticle]()
        let ref = Database.database().reference()
        
        guard let id = SCDatabaseQueryManager.savedSchool()?.schoolId else { return }
        
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
