//
//  HomeViewController.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/13/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

protocol HomeViewControllerProtocol: Presentable {
    var onDidSelectFeature: ((HomeFeature?) -> Void)? { get set }
    var onDidSelectLink: ((String) -> Void)? { get set }
}

class HomeViewController: SNBaseViewController, HomeViewControllerProtocol {

    // MARK: - Properties
    
    private var viewModel: HomeViewModelProtocol
    private let scrollView = UIScrollView(frame: .zero)
    private let wrapperView = UIView(frame: .zero)
    
    private var wrapperHeightConstraint: NSLayoutConstraint?
    
    private lazy var heroSectionView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var featureView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()
    
    private var linksListView: SchoolLinksListViewProtocol = SchoolLinksListView()
    
    private var totalHeight: CGFloat {
        return view.bounds.size.height * viewModel.scrollViewHeightMultiplier
    }
    
    // MARK: - HomeViewControllerProtocol
    
    var onDidSelectFeature: ((HomeFeature?) -> Void)?
    var onDidSelectLink: ((String) -> Void)?
    
    // MARK: - Init
    
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Fatal: Coder not implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = PageTitles.home.rawValue
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.pinToSafeArea()
        
        scrollView.addSubview(wrapperView)
        wrapperView.translatesAutoresizingMaskIntoConstraints = false
        wrapperView.pinToSuperview()
        
        wrapperHeightConstraint = wrapperView.heightAnchor.constraint(equalToConstant: totalHeight)
        wrapperHeightConstraint?.isActive = true
        wrapperView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        subscribeToLinksView()
        subscribeToViewModel()

        guard let linksListView = linksListView as? SchoolLinksListView else { return }

        wrapperView.addSubview(heroSectionView)
        wrapperView.addSubview(featureView)
        wrapperView.addSubview(linksListView)
        
        setupHomeView()
        
        viewModel.requestData()
    }
    
    // MARK: - Methods
    
    private func subscribeToLinksView() {
        linksListView.onDidSelectLink = onDidSelectLink
    }
    
    private func setupHomeView(){
        guard let linksListView = linksListView as? SchoolLinksListView else { return }
        
        heroSectionView.pinToTop()
        heroSectionView.pinToLeadingAndTrailing()
        heroSectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: viewModel.heroMultiplier).isActive = true
        setupHeroSubview()
        
        if viewModel.featuresIncluded && viewModel.linksIncluded {
            featureView.pinBelowView(view: heroSectionView)
            featureView.pinToLeadingAndTrailing()
            featureView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: viewModel.featureMultiplier).isActive = true
            
            linksListView.pinBelowView(view: featureView)
            linksListView.pinToLeadingAndTrailing()
            linksListView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: viewModel.linksMultiplier).isActive = true
        } else if viewModel.featuresIncluded {
            featureView.pinBelowView(view: heroSectionView)
            featureView.pinToLeadingAndTrailing()
            featureView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: viewModel.featureMultiplier).isActive = true
        } else if viewModel.linksIncluded {
            linksListView.pinBelowView(view: heroSectionView)
            linksListView.pinToLeadingAndTrailing()
            linksListView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: viewModel.linksMultiplier).isActive = true
        }
        
        wrapperHeightConstraint?.constant = totalHeight
        view.layoutIfNeeded()
    }
    
    private func setupHeroSubview() {
        heroSectionView.subviews.forEach { $0.removeFromSuperview() }
        heroSectionView.setMargins(top: Style.Layout.innerSpacing,
                            leading: Style.Layout.marginXL,
                            bottom: Style.Layout.marginXL,
                            trailing: Style.Layout.marginXL)
        
        let mainHeroView = HomeGreetingView()
        heroSectionView.addSubview(mainHeroView)
        mainHeroView.translatesAutoresizingMaskIntoConstraints = false
        mainHeroView.pinToMargins()
    }
    
    private func subscribeToViewModel() {
        viewModel.onFetchedSchoolAndSettings = { [weak self] in
            DispatchQueue.main.async {
                self?.setupHomeView()
            }
        }
        
        viewModel.onNetworkingDidFail = { [weak self] error in
            DispatchQueue.main.async {
                self?.present(error.initAlert(), animated: true, completion: nil)
            }
        }
    }
}
