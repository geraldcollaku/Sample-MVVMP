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
    case loaded(UserVM)
    case error
}

protocol ViewProtocol: AnyObject {
    func render(_ state: ViewState)
}

class UserPresenter {
    
    private let apiManager = ApiManager(session: Session())
    weak var view: ViewProtocol?
    
    init(view: ViewProtocol) {
        self.view = view
    }
    
    // MARK: - Public methods
    
    func getUser() {
        
        view?.render(.loading)
        
        apiManager.call(type: RequestItemsType.getUser) { (result: Swift.Result<User, Error>) in
            
            switch result {
            case .success(let user):
                let userVM = UserVM(from: user)
                self.view?.render(.loaded(userVM))
                break
            case .failure:
                self.view?.render(.error)
            }
        }
    }
}
