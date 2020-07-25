//
//  ApiManager.swift
//  Sample-MVVMP
//
//  Created by Gerald Collaku on 25.07.20.
//

import Alamofire
import Foundation

enum NetworkError: Error {
    case noData
    case failure
}

class ApiManager {
    
    private let sessionManager: Session
    
    init(session: Session) {
        self.sessionManager = session
    }
    
    func call<T: Codable>(type: EndPoint, parameters: Parameters? = nil, handler: @escaping (Swift.Result<T, Error>) -> Void) {
        
        self.sessionManager.request(type.url, method: type.httpMethod, parameters: parameters, encoding: type.encoding, headers: type.headers).validate().responseJSON { (data) in
            
            do {
                guard let jsonData = data.data else {
                    throw NetworkError.noData
                }
                let result = try JSONDecoder().decode(T.self, from: jsonData)
                handler(.success(result))
                
            } catch {
                handler(.failure(error))
            }
        }
    }
    
}
