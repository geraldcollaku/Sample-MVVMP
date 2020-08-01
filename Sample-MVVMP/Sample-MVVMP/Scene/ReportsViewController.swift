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
        
        tableView.register(ReportsCell.nib(), forCellReuseIdentifier: ReportsCell.reuseIdentifier)
        presenter = ReportsPresenter(view: self)
        presenter.loadInitialCovidReports()
    }
    
    private func updateView() {
        Spinner.stop()
        
        switch state {
        case .loading:
            Spinner.start(from: self.view)
            break
            
        case .loaded:
            UIView.transition(with: tableView, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.tableView.reloadData()
            })

            break
            
        case .error(let description):
            let title = description.localizedDescription
            let action = UIAlertAction(title: "OK", style: .default)
            displayAlert(with: title, actions: [action])
            break
            
        default:
            break
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - ViewProtocol
    
    func render(_ state: ViewState) {
        self.state = state
    }
    
    @IBAction func filterAction(_ sender: Any) {
        presenter.loadFilteredReports(true)
    }
    
    @IBAction func resetFilterAction(_ sender: Any) {
        presenter.loadFilteredReports(false)
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

