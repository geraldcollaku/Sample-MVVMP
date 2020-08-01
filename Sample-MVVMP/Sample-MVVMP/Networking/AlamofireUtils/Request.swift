//
//  RequestItems.swift
//  Sample-MVVMP
//
//  Created by Gerald Collaku on 25.07.20.
//

import Foundation
import Alamofire

enum RequestType {
    
    //MARK: - Reports
    
    case getDailyCovidReports
    
}

//MARK: - Endpoint types

extension RequestType: EndPoint {

    var baseUrl: String {
        return AppConfig.baseUrl
    }
    
    var path: String {
        switch self {
        case .getDailyCovidReports:
            return "countries"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var headers: HTTPHeaders? {
        return nil
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

}
