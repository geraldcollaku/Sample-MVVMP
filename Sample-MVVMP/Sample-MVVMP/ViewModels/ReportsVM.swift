//
//  ReportsVM.swift
//  Sample-MVVMP
//
//  Created by Gerald Collaku on 25.07.20.
//

import UIKit

struct ReportsVM: Equatable {
    
    private(set) var reports: [CountryReportsVM]
    
    init(from reports: [CountryReports]) {
        self.reports = []

        reports.forEach { report in
            let report = CountryReportsVM(from: report)
            self.reports.append(report)
        }
    }
    
    func filteringReports() -> ReportsVM {
        var newVM = self
        
        newVM.reports = self.reports.compactMap{ (item) -> CountryReportsVM? in
            if let name = item.name, !name.contains("World")  {
                    return nil
            }
            return item
        }
        
        return newVM
    }
    
    static func == (lhs: ReportsVM, rhs: ReportsVM) -> Bool {
        return lhs.reports.count != rhs.reports.count
    }
    
}

struct CountryReportsVM: RowVM {

    let name: String?
    let cases: String?
    let deaths: String?
    let todayCases: String?
    let todayDeaths: String?
    let recovered: String?
    let active: String?
    
    init(from country: CountryReports) {
        self.name = country.country
        self.cases = "Cases: \(country.cases ?? 0)"
        self.todayCases = "Today cases: \(country.todayCases ?? 0)"
        self.todayDeaths = "Today deaths: \(country.todayDeaths ?? 0)"
        self.recovered = "Recovered: \(country.recovered ?? 0)"
        self.active = "Active: \(country.active ?? 0)"
        self.deaths = "Deaths: \(country.deaths ?? 0)"
    }
    
    func cell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReportsCell.reuseIdentifier, for: indexPath) as! ReportsCell
        cell.viewModel = self
        return cell
    }
}

protocol RowVM {
    func cell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell
}
