//
//  ViewController.swift
//  InvioCekirgeProgrami2024
//
//  Created by Berat Ridvan Asilturk on 3.04.2024.
//
// TODO: -
// Favoriler Icin Realm
// Add MARK Props DidLoad (LifeCycle) vs
// Uygulama renklerini Invio renklerine gore ayarla


import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private let refreshControl = UIRefreshControl()
    private let viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: ExpandableCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: ExpandableCell.cellIdentifier)
        tableView.register(UINib(nibName: MainCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: MainCell.cellIdentifier)
        
        self.refreshControl.addTarget(self, action: #selector(self.refreshData), for: .valueChanged)
        self.tableView.refreshControl = self.refreshControl
        
        viewModel.fetchData{
            self.updateUI()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "FavListViewController") as! FavListViewController
            self.present(vc, animated: true)
        }
        
    }
    
    private func updateUI() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
            print("✅✅✅ UI UPDATED")
        }
    }
    
    @objc private func refreshData() {
        
        viewModel.resetContent()
        
        viewModel.fetchData{
            self.updateUI()
        }
    }
    
    
    @IBAction private func expandButtonTapped() {
        
        viewModel.closeExpandedCells()
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            print("🧲🧲🧲 All Cells Closed")
        }
    }
}

// MARK: - Table View Delegates
extension ViewController: UITableViewDelegate {
    
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
    
//     Pagination
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if viewModel.paginationFlag(indexPath: indexPath) {
            viewModel.fetchData(updatePage: true) {
                self.updateUI()
                print("🔁🔁🔁 PAGINATION SUCCEED")
            }
        }
    }
}

// MARK: TableView Data Source
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // section main cell title
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MainCell.cellIdentifier, for: indexPath) as! MainCell
            cell.title = viewModel.sections[safe: indexPath.section]?.dataModel.province
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
