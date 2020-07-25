//
//  ReportsViewController.swift
//  Sample-MVVMP
//
//  Created by Gerald Collaku on 25.07.20.
//

import UIKit

class ReportsViewController: UIViewController, ViewProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var presenter: ReportsPresenter!
    
    private var state: ViewState = .notLoaded {
        didSet {
            updateView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ReportsPresenter(view: self)
        presenter.getUser()
        tableView.register(ReportsCell.nib(), forCellReuseIdentifier: ReportsCell.reuseIdentifier)
    }
    
    private func updateView() {
        Spinner.stop()
        
        switch state {
        case .loading:
            Spinner.start(from: self.view)
            
        case .loaded:
            Spinner.stop()
            tableView.reloadData()
            
        default:
            break
        }
    }
    
    // MARK: - ViewProtocol
    
    func render(_ state: ViewState) {
        self.state = state
    }
    
}

extension ReportsViewController: UITableViewDataSource {
    
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

