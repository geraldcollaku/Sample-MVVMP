//
//  RequestItems.swift
//  Sample-MVVMP
//
//  Created by Gerald Collaku on 25.07.20.
//

import Foundation
import Alamofire

enum RequestItemsType {
    
    // MARK: - Events
    case events(_: String)
    
    //MARK: User
    
    case getUser
    
}

//MARK: - Endpoint types

extension RequestItemsType: EndPoint {

    var baseUrl: String {
        return AppConfig.baseUrl
    }
    
    var path: String {
        switch self {
        case .events(_):
            return "events"
        case .getUser:
            return "user"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var headers: HTTPHeaders? {
        return ["Content-Type": "application/json",
                "X-Requested-With": "XMLHttpRequest"]
    }
    
    var url: URL {
        return URL(string: baseUrl+path)!
    }
    
    var encoding: ParameterEncoding {
        switch self {
        default:
            return JSONEncoding.default
        }
    }
    
    var version: String {
        return "/v0_1"
    }
}
