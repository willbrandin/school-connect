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
    var numberOfRowsInHomeCollectionView: Int { get }
    
    // MARK: - Closures
    var onNetworkingDidFail: ((SCErrors) -> Void)? { get set }
    var onFetchedSchoolAndSettings: (() -> Void)? { get set }
    
    // MARK: - Methods
    func requestData()
    func layoutFor(_ indexPath: IndexPath, with width: CGFloat) -> CGSize
}

class HomeViewModel: HomeViewModelProtocol {
    
    private var schoolId: String?
    private var appSettings: SNAppSettings?
    private var school: School?
    private var homeLinks = [SCHomeLink]()
    
    private let dispatchGroup = DispatchGroup()
    
    var numberOfRowsInHomeCollectionView: Int {
        if featuresIncluded && linksIncluded {
            return 3
        } else if featuresIncluded || linksIncluded {
            return 2
        }
        return 1
    }
    
    private var featuresIncluded: Bool {
        guard let features = appSettings?.features else { return false }
        return !features.isEmpty
    }
    
    private var linksIncluded: Bool {
        return !homeLinks.isEmpty
    }
    
    var onNetworkingDidFail: ((SCErrors) -> Void)?
    var onFetchedSchoolAndSettings: (() -> Void)?
    
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
    
    func layoutFor(_ indexPath: IndexPath, with width: CGFloat) -> CGSize {
        let screenHeight = UIScreen.main.bounds.height
        if indexPath.row == HomeCellIndex.greeting.rawValue {
            return CGSize(width: width, height: screenHeight * 0.6)
            
        } else if indexPath.row == HomeCellIndex.featureCell.rawValue && featuresIncluded {
            return CGSize(width: width, height: screenHeight * 0.45)
            
        } else if indexPath.row == HomeCellIndex.linksCell.rawValue || linksIncluded {
            if homeLinks.count > 3 {
                return CGSize(width: width, height: screenHeight
                    * 0.44)
            }
            return CGSize(width: width, height: screenHeight * 0.3)
        }
        return CGSize(width: width, height: screenHeight * 0.3)
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
