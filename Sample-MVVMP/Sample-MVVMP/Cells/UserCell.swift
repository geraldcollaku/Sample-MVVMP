//
//  UserCell.swift
//  Sample-MVVMP
//
//  Created by Gerald Collaku on 25.07.20.
//

import UIKit

class UserCell: UITableViewCell, Reusable {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    var viewModel: UserVM? {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        guard let viewModel = viewModel else {
            return
        }
        nameLabel.text = viewModel.name
        emailLabel.text = viewModel.email
    }
    
}
