//
//  UserPresenter.swift
//  Sample-MVVMP
//
//  Created by Gerald Collaku on 25.07.20.
//

import Foundation
import Alamofire

enum ViewState {
    case notLoaded
    case loading
    case loaded(ReportsVM)
    case error(Error)
}

protocol ViewProtocol: AnyObject {
    func render(_ state: ViewState)
}

class ReportsPresenter {
    
    private let apiManager = ApiManager(session: Session())
    
    private var viewModel: ReportsVM? // viewModel independent from the state
    
    private(set) weak var view: ViewProtocol?
    
    private var state: ViewState = .notLoaded {
        didSet {
            view?.render(state)
        }
    }
    
    init(view: ViewProtocol) {
        self.view = view
    }
    
    // MARK: - Public methods
    
    func loadInitialCovidReports() {
        
        state = .loading
        apiManager.call(endpoint: RequestType.getDailyCovidReports) { (result: Swift.Result<[CountryReports], Error>) in
            
            switch result {
            case .success(let reports):
                let reportsVM = ReportsVM(from: reports)
                self.viewModel = reportsVM
                self.state = .loaded(reportsVM)
                break
                
            case .failure(let description):
                self.state = .error(description)
            }
        }
    }
    
    func loadFilteredReports(_ isFilterActive: Bool) {
        guard case .loaded = state, let viewModel = viewModel else { return }
        if isFilterActive {
            let filterViewModel = viewModel.filteringReports()
            state = .loaded(filterViewModel)
        } else {
            state = .loaded(viewModel)
        }
    }
    
}
