//
//  ViewController.swift
//  InvioCekirgeProgrami2024
//
//  Created by Berat Ridvan Asilturk on 3.04.2024.
//
// TODO: -
// OPTIONAL KURTUL
// Favoriler Realm

import UIKit

final class MainTableViewController: UITableViewController {
    
    private let cellIdentifier = "cellIdentifier"
    private let viewModel: MainViewModel
    
    required init?(coder: NSCoder) {
        self.viewModel = MainViewModel()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    private func getData() {
        viewModel.fetchData(pageNum: viewModel.currentPage, completion: {
            self.setUI()
        })
    }
    
    private func setUI() {
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(self.refreshData), for: .valueChanged)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            print("✅✅✅ UI UPDATED")
        }
    }
    
    @objc private func refreshData() {
        
        viewModel.currentPage = 1
        
        self.refreshControl?.beginRefreshing()
        self.viewModel.dataArray.removeAll()
        
        viewModel.fetchData(pageNum: viewModel.currentPage, completion: {
            self.tableView.reloadData()
        })
        
        self.refreshControl?.endRefreshing()
        print("🔄🔄🔄 Refreshed")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if viewModel.currentPage < viewModel.totalPage && indexPath.row == viewModel.dataArray.count - 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "loading")
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            let data = viewModel.dataArray[indexPath.row]
            cell.textLabel?.text = data.province
            return cell
        }
    }
    
    // Pagination
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if viewModel.currentPage < viewModel.totalPage && indexPath.row == viewModel.dataArray.count - 1 {
            viewModel.currentPage = viewModel.currentPage + 1
            
            viewModel.fetchData(pageNum: viewModel.currentPage, completion: {
                self.setUI()
            })
        }
    }
}
