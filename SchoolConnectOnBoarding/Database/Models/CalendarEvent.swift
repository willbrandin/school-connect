//
//  CalendarEvent.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/13/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import Foundation
import Firebase

class CalendarEvent {
    
    //MARK: Properties
    var title: String?
    var startDate: String?
    var endDate: String?
    var description: String?
    var location: String?
    
    
    //MARK: Inits
    func initWithResponse(_ dataDictionary: NSDictionary){
        self.title = dataDictionary["title"] as? String
        self.startDate = dataDictionary["startDate"] as? String
        self.endDate = dataDictionary["endDate"] as? String
        self.description = dataDictionary["description"] as? String
        self.location = dataDictionary["location"] as? String
    }
    
    
    //MARK: Methods
    static func downloadEventData(completion: @escaping ([CalendarEvent]) -> Void) {
        var eventsArray = [CalendarEvent]()
        //Firebase Reference
        let ref = Database.database().reference()
        
        guard let id = SNDatabaseQueryManager.savedSchool()?.schoolId else { return }
        
        let calendarEventRef = ref.child(FirebasePathStrings.calendarPath.rawValue).child(id)
        
        calendarEventRef.observe(.childAdded) { (snapshot) in
            if let data = snapshot.value as? NSDictionary {
                let newEvent = CalendarEvent()
                newEvent.initWithResponse(data)
                eventsArray.append(newEvent)
                completion(eventsArray)
            }
        }
    }
    
}
