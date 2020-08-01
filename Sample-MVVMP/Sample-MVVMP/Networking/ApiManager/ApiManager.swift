//
//  ApiManager.swift
//  Sample-MVVMP
//
//  Created by Gerald Collaku on 25.07.20.
//

import Alamofire
import Foundation

enum NetworkError: Error {
    case dataNotFound

    var localizedDescription: String {
        switch self {
        case .dataNotFound:
            return NSLocalizedString("No data found. Please try again...", comment: "")
        }
    }
}

typealias Handler<T> = (Swift.Result<T, Error>) -> Void

class ApiManager {
    
    private let sessionManager: Session
    
    init(session: Session) {
        self.sessionManager = session
    }
    
     func call<T: Codable>(endpoint: EndPoint, parameters: Parameters? = nil, handler: @escaping Handler<T>) {
        
        self.sessionManager.request(endpoint.url, method: endpoint.httpMethod, parameters: parameters, encoding: endpoint.encoding, headers: endpoint.headers).validate().responseJSON { (data) in
            
            do {
                guard let data = data.data else {
                    handler(.failure(NetworkError.dataNotFound))
                    return
                }
                
                let responseObject = try JSONDecoder().decode(T.self, from: data)
                handler(.success(responseObject))
                
            } catch {
                handler(.failure(error))
            }
        }
    }
    
}
