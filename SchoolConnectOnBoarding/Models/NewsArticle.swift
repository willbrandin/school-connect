//
//  NewsArticle.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/13/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import Foundation

class NewsArticle: Codable {
    
    //MARK: Properties
    
    var title: String?
    var subtitle: String?
    var pubDate: String?
    var imgUrl: String?
    var fullStory: String?
    var schoolId: String?
    
    enum CodingKeys: String, CodingKey {
        case title, subtitle, pubDate, imgUrl
        case fullStory = "story"
        case schoolId = "school"
    }
    
    //MARK: Methods
    static func fetchNewsData(completion: @escaping ([NewsArticle], Error?) -> Void) {
        
        let userDefaults = UserDefaults.standard
        guard let id = userDefaults.string(forKey: UserDefaultKeys.selectedId.rawValue) else { return }
        
        let networkManager = NetworkManager.sharedInstance
        let endpoint = SchoolConnectAPI.news(id: id)
        
        networkManager.requestWithListResponse(for: endpoint, [NewsArticle].self) { (result) in
            switch result {
            case .success(let news):
                let returnedNews = news
                completion(returnedNews, nil)
            case .error:
                completion([], SCErrors.noFetchedNews)
            }
        }
    }
}
