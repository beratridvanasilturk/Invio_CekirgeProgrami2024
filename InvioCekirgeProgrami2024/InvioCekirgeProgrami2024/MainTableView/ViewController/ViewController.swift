//
//  ViewController.swift
//  InvioCekirgeProgrami2024
//
//  Created by Berat Ridvan Asilturk on 3.04.2024.
//
// TODO: -
// Favoriler Icin Realm


import UIKit

final class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
//    private let cellIdentifier = "cellIdentifier"
    private let viewModel: MainViewModel
//    
    required init?(coder: NSCoder) {
        self.viewModel = MainViewModel()
        super.init(coder: coder)
    }
    
    
//    var sections: [Section] = [
//        Section(
//            mainCellTitle: "1~3",
//            hideContent: true,
//            contentList: [
//                ExpandableCellContentModel(title: "1", hideContent: true),
//                ExpandableCellContentModel(title: "2", hideContent: true),
//                ExpandableCellContentModel(title: "3", hideContent: true)
//            ]),
//        Section(
//            mainCellTitle: "4~6",
//            hideContent: true,
//            contentList: [
//                ExpandableCellContentModel(title: "4", hideContent: true),
//                ExpandableCellContentModel(title: "5", hideContent: true),
//                ExpandableCellContentModel(title: "6", hideContent: true)
//            ]),
//        Section(
//            mainCellTitle: "7~9",
//            hideContent: true,
//            contentList: [
//                ExpandableCellContentModel(title: "7", hideContent: true),
//                ExpandableCellContentModel(title: "8", hideContent: true),
//                ExpandableCellContentModel(title: "9", hideContent: true)
//            ]),
//    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: ExpandableCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: ExpandableCell.cellIdentifier)
        tableView.register(UINib(nibName: MainCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: MainCell.cellIdentifier)
        
        
        getData()
    }
    
    private func getData() {
        viewModel.fetchData(pageNum: viewModel.currentPage, completion: {
            self.setUI()
        })
    }
    
    private func setUI() {
        
//        self.tableView.refreshControl = UIRefreshControl()
//        self.tableView.refreshControl?.addTarget(self, action: #selector(self.refreshData), for: .valueChanged)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            print("✅✅✅ UI UPDATED")
        }
    }
    
    @objc private func refreshData() {
        
        viewModel.currentPage = 1
        
        self.tableView.refreshControl?.beginRefreshing()
        self.viewModel.dataArray.removeAll()
        
        viewModel.fetchData(pageNum: viewModel.currentPage, completion: {
            self.tableView.reloadData()
        })
        
//        self.refreshControl?.endRefreshing()
        print("🔄🔄🔄 Refreshed")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel.dataArray.count
        let section = viewModel.sections[section]
        if !section.hideContent {
            return section.contentList.count + 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        if viewModel.currentPage < viewModel.totalPage && indexPath.row == viewModel.dataArray.count - 1 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "loading")
//            return cell!
//        } else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
//            let data = viewModel.dataArray[indexPath.row]
//            cell.textLabel?.text = data.province
//            return cell
//        }
        
        
        // section main cell title
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MainCell.cellIdentifier, for: indexPath) as! MainCell
            cell.label.text = viewModel.sections[indexPath.section].dataModel?.province
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ExpandableCell.cellIdentifier, for: indexPath) as! ExpandableCell
            let model = viewModel.sections[indexPath.section].contentList[indexPath.row - 1]

            cell.model = model
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        if indexPath.row == 0 {
            viewModel.sections[indexPath.section].hideContent = !viewModel.sections[indexPath.section].hideContent
            
            tableView.reloadData()

        } else {
            let cell = tableView.cellForRow(at: indexPath) as? ExpandableCell
            viewModel.sections[indexPath.section].contentList[indexPath.row - 1].hideContent.toggle()

            tableView.reloadRows(at: [indexPath], with: .none)
        }

    }
    
    
    // Pagination
//    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if viewModel.currentPage < viewModel.totalPage && indexPath.row == viewModel.dataArray.count - 1 {
//            viewModel.currentPage = viewModel.currentPage + 1
//            
//            viewModel.fetchData(pageNum: viewModel.currentPage, completion: {
//                self.setUI()
//            })
//        }
//    }
}
