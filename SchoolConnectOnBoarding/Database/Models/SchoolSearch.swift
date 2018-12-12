//
//  SchoolName.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/11/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import Foundation

class SchoolSearch: Decodable {
    
    //MARK: - Properties
    var name: String?
    var id: String?
    
    //MARK: - Init
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)!
        id = try values.decodeIfPresent(String.self, forKey: .id)!
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case id = "_id"
    }
    
    //MARK: - Methods
    static func fetchList(with searchQuery: String?, completion: @escaping (Result<[SchoolSearch], Error?>)->Void){
        guard let query = searchQuery else {
            completion(Result.error(SCErrors.noSchoolId))
            return
        }
        
        let networkManager = NetworkManager.sharedInstance
        let endpoint = SchoolConnectAPI.schoolSearch(search: query)
        
        networkManager.requestWithListResponse(for: endpoint, [SchoolSearch].self) { result in
            switch result {
            case .success(let schools):
                let returnedSchools = schools as! [SchoolSearch]
                completion(Result.success(returnedSchools))
            case .error(let err):
                completion(Result.error(err))
            }
        }
    }
    
}
