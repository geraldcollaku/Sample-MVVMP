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
    private var state: ViewState = .notLoaded
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = UserPresenter(view: self)
        presenter.getUser()
        tableView.register(UserCell.nib(), forCellReuseIdentifier: UserCell.reuseIdentifier)
    }
    
    func render(_ state: ViewState) {
        self.state = state
        tableView.reloadData()
    }
}

extension UserViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch state {
        case .loaded(_):
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch state {
        case .loaded(let userVM):
            return userVM.cell(tableView, for: indexPath)
        default:
            fatalError("invalid state")
        }
    }
    
}

