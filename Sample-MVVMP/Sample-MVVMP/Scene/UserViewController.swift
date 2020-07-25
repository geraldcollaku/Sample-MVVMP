//
//  UserViewController.swift
//  Sample-MVVMP
//
//  Created by Gerald Collaku on 25.07.20.
//

import UIKit

class UserViewController: UIViewController, ViewProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var presenter: UserPresenter!
    
    private var state: ViewState = .notLoaded {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = UserPresenter(view: self)
        presenter.getUser()
        tableView.register(UserCell.nib(), forCellReuseIdentifier: UserCell.reuseIdentifier)
    }
    
    func render(_ state: ViewState) {
        self.state = state
    }
}

extension UserViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch state {
        case .loaded(let reportsVM):
            return reportsVM.reports.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch state {
        case .loaded(let reportsVM):
            let rowVM = reportsVM.reports[indexPath.row]
            return rowVM.cell(tableView, for: indexPath)
        default:
            fatalError("invalid state")
        }
    }
    
}

