//
//  User.swift
//  Sample-MVVMP
//
//  Created by Gerald Collaku on 25.07.20.
//

import Foundation

struct User: Codable {
    let fullName: String?
    let email: String?
    let isPrime: Bool?
    let paymentMethods: [String]?
}
