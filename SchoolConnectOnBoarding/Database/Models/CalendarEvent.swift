//
//  CalendarEvent.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/13/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import Foundation

class CalendarEvent: Decodable {
    
    //MARK: Properties
    var title: String?
    var startDate: String?
    var endDate: String? = "2018-04-22T13:20:55.302Z"
    var description: String?
    var location: String?
    var schoolId: String?
    
    //MARK: - Init
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        startDate = try values.decodeIfPresent(String.self, forKey: .startDate)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        schoolId = try values.decodeIfPresent(String.self, forKey: .schoolId)
    }
    
    enum CodingKeys: String, CodingKey
    {
        case title, startDate, description, location
        
        case schoolId = "school"
    }
    
    
    
    //MARK: Methods
    
    static func fetchEvents(completion: @escaping ([CalendarEvent], Error?) -> Void) {
        
        let userDefaults = UserDefaults.standard
        guard let id = userDefaults.string(forKey: UserDefaultKeys.selectedId.rawValue) else { return }
        let networkManager = NetworkManager.sharedInstance
        let endpoint = SchoolConnectAPI.calendar(id: id)
        
        networkManager.requestWithListResponse(for: endpoint, [CalendarEvent].self) { (result) in
            switch result {
            case .success(let events):
                let returnedEvents = events as! [CalendarEvent]
                completion(returnedEvents, nil)
            case .error:
                completion([], SCErrors.noFetchedEvents)
            }
        }
        
    }
    
    
}
