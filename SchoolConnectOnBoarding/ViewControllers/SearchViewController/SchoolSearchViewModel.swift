//
//  SchoolSearchViewModel.swift
//  SchoolConnectOnBoarding
//
//  Created by Will Brandin on 12/13/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

protocol SchoolSearchViewModelProtocol {
    // MARK: - Properties
    var numberOfRows: Int { get }
    var numberOfSections: Int { get }
    // MARK: - Closures
    var onNetworkingDidFail: ((SCErrors) -> Void)? { get set }
    var onDidSetSchools: (() -> Void)? { get set }
    var onDisplayNoSchools: (() -> Void)? { get set }
    
    // MARK: - Methods
    func determineFetch(for search: String)
    func schoolName(for indexPath: IndexPath) -> String?
    func schoolId(for indexPath: IndexPath) -> String?
}

class SchoolSearchViewModel: SchoolSearchViewModelProtocol {
    
    var onNetworkingDidFail: ((SCErrors) -> Void)?
    var onDidSetSchools: (() -> Void)?
    var onDisplayNoSchools: (() -> Void)?
    
    var schools = [SchoolSearch]() {
        didSet {
            if schools.isEmpty {
                onDisplayNoSchools?()
            } else {
                onDidSetSchools?()
            }
        }
    }
    
    var numberOfRows: Int {
        return schools.count
    }
    
    var numberOfSections: Int {
        return 1
    }
    
    func schoolName(for indexPath: IndexPath) -> String? {
        return schools[indexPath.row].name
    }
    
    func determineFetch(for search: String) {
        if search.count == 0 {
            schools.removeAll()
        } else if search.count > 2 {
            let strResult = search.removeSpecialCharactersFromText()
            fetchWithSearch(query: strResult)
        }
    }
    
    func schoolId(for indexPath: IndexPath) -> String? {
        return schools[indexPath.row].id
    }
    
    private func fetchWithSearch(query: String) {
        fetchList(with: query) { [weak self] result in
            self?.handleSchoolSearchResult(with: result)
        }
    }
    
    private func handleSchoolSearchResult(with result: Result<[SchoolSearch], Error?>) {
        switch result {
        case .success(let schools):
            self.schools = schools
        case .error:
            onNetworkingDidFail?(SCErrors.fetchError)
        }
    }
    
    private func fetchList(with searchQuery: String?, completion: @escaping (Result<[SchoolSearch], Error?>)->Void){
        guard let query = searchQuery else {
            completion(Result.error(SCErrors.noSchoolId))
            return
        }
        
        let networkManager = NetworkManager.sharedInstance
        let endpoint = SchoolConnectAPI.schoolSearch(search: query)
        
        networkManager.requestWithListResponse(for: endpoint, [SchoolSearch].self) { result in
            switch result {
            case .success(let schools):
                let returnedSchools = schools
                completion(Result.success(returnedSchools))
            case .error(let err):
                completion(Result.error(err))
            }
        }
    }
    
}
