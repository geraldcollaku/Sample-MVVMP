//
//  UserCell.swift
//  Sample-MVVMP
//
//  Created by Gerald Collaku on 25.07.20.
//

import UIKit

class UserCell: UITableViewCell, Reusable {
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var casesLabel: UILabel!
    @IBOutlet weak var todayCasesLabel: UILabel!
    @IBOutlet weak var deathsLabel: UILabel!
    @IBOutlet weak var recoveredLabel: UILabel!
    @IBOutlet weak var activeLabel: UILabel!
    
    
    var viewModel: CountryReportsVM? {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        guard let viewModel = viewModel else {
            return
        }
        countryLabel.text = viewModel.name
        casesLabel.text = viewModel.cases
        todayCasesLabel.text = viewModel.todayCases
        deathsLabel.text = viewModel.deaths
        recoveredLabel.text = viewModel.recovered
        activeLabel.text = viewModel.active
    }
    
}
