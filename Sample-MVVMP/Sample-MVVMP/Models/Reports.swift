//
//  Reports.swift
//  Sample-MVVMP
//
//  Created by Gerald Collaku on 25.07.20.
//

import Foundation

struct CountryReports: Codable {
    let country: String?
    let cases, todayCases, deaths, todayDeaths: Int?
    let recovered, active: Int?
    let critical, casesPerOneMillion, deathsPerOneMillion, totalTests: Int?
    let testsPerOneMillion: Int?
}
