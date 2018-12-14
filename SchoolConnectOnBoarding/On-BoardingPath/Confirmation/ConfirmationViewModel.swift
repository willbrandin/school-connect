//
//  ConfirmationViewModel.swift
//  SchoolConnectOnBoarding
//
//  Created by Will Brandin on 12/13/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

protocol ConfirmationViewModelProtocol {
    // MARK: - Closures
    var onDidSetSchool: ((ConfirmationUIModel) -> Void)? { get set }
    var onNetworkLoading: (() -> Void)? { get set }
    var onNetworkingDidFail: ((SCErrors) -> Void)? { get set }
    
    // MARK: - Methods
    func requestSchoolDetails()
}

class ConfirmationViewModel: ConfirmationViewModelProtocol {
    
    var onNetworkingDidFail: ((SCErrors) -> Void)?
    var onDidSetSchool: ((ConfirmationUIModel) -> Void)?
    var onNetworkLoading: (() -> Void)?
    
    var selectedSchoolId: String
    
    var school: School? {
        didSet {
            let uiModel = ConfirmationUIModel(name: school?.schoolName,
                                              city: school?.schoolCity,
                                              state: school?.schoolState)
            onDidSetSchool?(uiModel)
        }
    }
    
    init(with id: String) {
        self.selectedSchoolId = id
    }
    
    func requestSchoolDetails() {
        fetchDetails { [weak self] result in
            self?.handleSchoolDetailResult(with: result)
        }
    }
    
    private func handleSchoolDetailResult(with result: Result<School, Error>) {
        switch result {
        case .success(let school):
            self.school = school
        case .error:
            onNetworkingDidFail?(SCErrors.fetchError)
        }
    }

    private func fetchDetails(completion: @escaping (Result<School, Error>)->Void) {
       
        let networkManager = NetworkManager.sharedInstance
        let endpoint = SchoolConnectAPI.schoolDetails(id: selectedSchoolId)
        
        networkManager.request(for: endpoint, School.self) { result in
            switch result {
            case .success(let school):
                guard let returnedSchool = school as? School else {
                    completion(.error(SCErrors.fetchError))
                    return
                }
                completion(.success(returnedSchool))
            case .error(let error):
                completion(.error(error))
            }
        }
    }
    
}
