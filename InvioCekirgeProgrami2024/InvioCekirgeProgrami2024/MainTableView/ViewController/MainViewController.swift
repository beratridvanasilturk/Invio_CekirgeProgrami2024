//
//  ViewController.swift
//  InvioCekirgeProgrami2024
//
//  Created by Berat Ridvan Asilturk on 3.04.2024.
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Props
    private let refreshControl = UIRefreshControl()
    var viewModel: MainViewModel!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: ExpandableCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: ExpandableCell.cellIdentifier)
        tableView.register(UINib(nibName: MainCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: MainCell.cellIdentifier)
        
        self.refreshControl.addTarget(self, action: #selector(self.refreshData), for: .valueChanged)
        self.tableView.refreshControl = self.refreshControl
       
        title = "Üniversiteler"
        let favButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(favButtonTapped))
        navigationItem.rightBarButtonItem = favButtonItem
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        PersistentManager.shared.delegate = self
        self.tableView.reloadData()
    }
    
    // MARK: - Funcs
    private func updateUI() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
            print("✅✅✅ UI UPDATED")
        }
    }
    
    @objc private func refreshData() {
        viewModel.resetContent()
        viewModel.fetchData{_ in 
            self.updateUI()
        }
    }
    
    @objc private func favButtonTapped() {
        let favListViewController = self.storyboard?.instantiateViewController(withIdentifier: "FavListViewController") as! FavoriteListViewController
        self.navigationController?.pushViewController(favListViewController, animated: true)
    }
    
    
    // MARK: - Actions
    @IBAction private func expandButtonTapped() {
        viewModel.closeExpandedCells()
        DispatchQueue.main.async {
            self.tableView.reloadData()
            print("🧲🧲🧲 All Cells Closed")
        }
    }
}

// MARK: - Table View Delegates
extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        if indexPath.row == 0 {
            viewModel.sectionSelected(indexPath: indexPath)
            tableView.reloadData()
            // Content icerigi tiklandiginda
        } else {
            viewModel.contentSelected(indexPath: indexPath)
            tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    // MARK: - Pagination
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if viewModel.paginationFlag(indexPath: indexPath) {
            viewModel.fetchData(updatePage: true) {_ in 
                self.updateUI()
                print("🔁🔁🔁 PAGINATION SUCCEED")
            }
        }
    }
}

// MARK: TableView Data Source
extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // section main cell title
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MainCell.cellIdentifier, for: indexPath) as! MainCell
            let model = viewModel.sections[safe: indexPath.section]
            cell.model = model
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ExpandableCell.cellIdentifier, for: indexPath) as! ExpandableCell
            let model = viewModel.sections[safe: indexPath.section]?.contentList[safe: indexPath.row - 1]
            cell.model = model
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = viewModel.sections[section]
        if !section.hideContent {
            return section.contentList.count + 1
        } else {
            return 1
        }
    }
}

// MARK: Persistent Manager Delegate
extension MainViewController: PersistentManagerDelegate {
    func favListUpdated() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
