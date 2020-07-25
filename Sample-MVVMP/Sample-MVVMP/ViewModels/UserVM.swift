//
//  UserVM.swift
//  Sample-MVVMP
//
//  Created by Gerald Collaku on 25.07.20.
//

import UIKit

struct UserVM: RowVM {

    let name: String?
    let email: String?
    
    init(from user: User) {
        self.name = user.fullName
        self.email = user.email
    }
    
    func cell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.reuseIdentifier, for: indexPath) as! UserCell
        cell.viewModel = self
        return cell
    }
}

protocol RowVM {
    func cell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell
}
