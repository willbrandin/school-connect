//
//  HomeViewModel.swift
//  SchoolConnectOnBoarding
//
//  Created by Will Brandin on 12/14/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

protocol HomeViewModelProtocol {
    
    // MARK: - Properties
    var heroMultiplier: CGFloat { get }
    var featureMultiplier: CGFloat { get }
    var linksMultiplier: CGFloat { get }
    
    var featuresIncluded: Bool { get }
    var linksIncluded: Bool { get}
    var scrollViewHeightMultiplier: CGFloat { get }
    
    // MARK: - Closures
    
    var onNetworkingDidFail: ((SCErrors) -> Void)? { get set }
    var onFetchedSchoolAndSettings: (() -> Void)? { get set }
    
    // MARK: - Methods
    
    func requestData()
}

class HomeViewModel: HomeViewModelProtocol {
    
    private var schoolId: String?
    private var appSettings: SNAppSettings?
    private var school: School?
    private var homeLinks = [SCHomeLink]()
    
    private let dispatchGroup = DispatchGroup()
    
    var heroMultiplier: CGFloat {
        return 0.6
    }
    var featureMultiplier: CGFloat {
        return 0.5
    }
    var linksMultiplier: CGFloat {
        return 0.4
    }
    
    var featuresIncluded: Bool {
        guard let features = appSettings?.features else { return false }
        return !features.isEmpty
    }
    
    var linksIncluded: Bool {
        return !homeLinks.isEmpty
    }
    
    var scrollViewHeightMultiplier: CGFloat {
        switch numberOfRowsInHomeCollectionView {
        case 3:
            return heroMultiplier + featureMultiplier + linksMultiplier
            
        case 2:
            if featuresIncluded {
                return heroMultiplier + featureMultiplier
            } else if linksIncluded {
                return heroMultiplier + linksMultiplier
            }
            return 0
            
        case 1:
            return heroMultiplier
            
        default:
            return 0
        }
    }
    
    var onNetworkingDidFail: ((SCErrors) -> Void)?
    var onFetchedSchoolAndSettings: (() -> Void)?
    
    private var numberOfRowsInHomeCollectionView: Int {
        if featuresIncluded && linksIncluded {
            return 3
        } else if featuresIncluded || linksIncluded {
            return 2
        }
        return 1
    }
    
    init(schoolId: String?) {
        self.schoolId = schoolId
    }
    
    func requestData() {
        requestSchool()
        requestAppConfigSettings()
        requestHomeLinks()
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.onFetchedSchoolAndSettings?()
        }
    }
    
    private func requestSchool() {
        fetchSchool(with: schoolId) { [weak self] result in
            self?.handleFetchSchoolResult(with: result)
        }
    }
    
    private func requestAppConfigSettings() {
        fetchAppConfigSettings(with: schoolId) { [weak self] result in
            self?.handleAppConfigSettingsResult(with: result)
        }
    }
    
    private func requestHomeLinks() {
        fetchHomeLinks(with: schoolId) { [weak self] result in
            self?.handleFetchHomeLinksResult(with: result)
        }
    }
}

extension HomeViewModel {
    
    private func fetchSchool(with schoolId: String?, completion: @escaping ((Result<School, SCErrors>) -> Void)) {
        
        guard let id = schoolId else {
            completion(.error(SCErrors.noSchoolId))
            return
        }
        
        let networkManager = NetworkManager.sharedInstance
        let endpoint = SchoolConnectAPI.schoolDetails(id: id)
        
        dispatchGroup.enter()
        networkManager.request(for: endpoint, School.self) { [weak self] result in
            switch result {
            case .success(let school):
                completion(.success(school))
            case .error:
                completion(.error(SCErrors.fetchError))
            }
            self?.dispatchGroup.leave()
        }
    }
    
    private func handleFetchSchoolResult(with result: Result<School, SCErrors>) {
        switch result {
        case .success(let school):
            UserDefaultsManager.selectedUserSchoolId = school.schoolId
            UserDefaultsManager.userSelectedSchool = school
            self.school = school
        case .error(let error):
            onNetworkingDidFail?(error)
        }
    }
    
    private func fetchAppConfigSettings(with schoolId: String?, completion: @escaping ((Result<SNAppSettings, SCErrors>) -> Void)) {
        guard let id = schoolId else {
            completion(.error(SCErrors.noSchoolId))
            return
        }
        
        let networkManager = NetworkManager.sharedInstance
        let endpoint = SchoolConnectAPI.configSettings(id: id)
        
        dispatchGroup.enter()
        networkManager.request(for: endpoint, SNAppSettings.self) { [weak self] result in
            switch result {
            case .success(let settings):
                completion(.success(settings))
            case .error:
                completion(.error(SCErrors.fetchError))
            }
            self?.dispatchGroup.leave()
        }
    }
    
    private func handleAppConfigSettingsResult(with result: Result<SNAppSettings, SCErrors>) {
        switch result {
        case .success(let settings):
            UserDefaultsManager.userSelectedSchoolConfiguration = settings
            appSettings = settings
        case .error(let error):
            onNetworkingDidFail?(error)
        }
    }
    
    private func fetchHomeLinks(with schoolId: String?, completion: @escaping ((Result<[SCHomeLink], SCErrors>) -> Void)){
        guard let id = schoolId else {
            completion(.error(SCErrors.noSchoolId))
            return
        }
        let networkManager = NetworkManager.sharedInstance
        let endpoint = SchoolConnectAPI.homeLinks(id: id)
        
        dispatchGroup.enter()
        networkManager.requestWithListResponse(for: endpoint, [SCHomeLink].self) { [weak self] result in
            switch result {
            case .success(let links):
                completion(.success(links))
            case .error:
                completion(.error(SCErrors.noSchoolLinks))
            }
            self?.dispatchGroup.leave()
        }
    }
    
    private func handleFetchHomeLinksResult(with result: Result<[SCHomeLink], SCErrors>) {
        switch result {
        case .success(let links):
            homeLinks = links
        case .error(let error):
            onNetworkingDidFail?(error)
        }
    }
}
