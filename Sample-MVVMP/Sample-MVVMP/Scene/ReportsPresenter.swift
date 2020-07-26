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
    case error
}

protocol ViewProtocol: AnyObject {
    func render(_ state: ViewState)
}

class ReportsPresenter {
    
    private let apiManager = ApiManager(session: Session())
    weak var view: ViewProtocol?
    
    init(view: ViewProtocol) {
        self.view = view
    }
    
    // MARK: - Public methods
    
    func loadCovidReports() {
        
        view?.render(.loading)
        
        apiManager.call(type: RequestType.getDailyCovidReports) { (result: Swift.Result<[CountryReports], Error>) in
            
            switch result {
            
            case .success(let reports):
                let reportsVM = ReportsVM(from: reports)
                self.view?.render(.loaded(reportsVM))
                break
                
            case .failure:
                self.view?.render(.error)
            }
        }
    }
}
