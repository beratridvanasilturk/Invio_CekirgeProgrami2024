//
//  ViewController.swift
//  InvioCekirgeProgrami2024
//
//  Created by Berat Ridvan Asilturk on 3.04.2024.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    let cellIdentifier = "cellIdentifier"
    let taskUrl = "https://storage.googleapis.com/invio-com/usg-challenge/universities-at-turkey/page-1.json"
    var dataArray = [DataResponseModel]()
    var totalPage = 1
    var currentPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        refreshData()
    }
    
    @objc private func refreshData() {
        currentPage = 1
        fetchData(pageNum: 1, refresh: true)
    }
    
    func fetchData(pageNum: Int, refresh: Bool = false) {
        DispatchQueue.main.async {
            if refresh {
                self.refreshControl?.beginRefreshing()
            }
        }
        
        let urlString = "https://storage.googleapis.com/invio-com/usg-challenge/universities-at-turkey/page-\(pageNum).json"
        let url = URL(string: urlString)
        
        guard url != nil else {
            print("😵😵😵 URL ERROR")
            return
        }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { data, response, error in
            DispatchQueue.main.async {
                if refresh {
                    self.dataArray.removeAll()
                    self.refreshControl?.endRefreshing()
                    print("🔄🔄🔄 Refreshed")
                }
            }
            if error == nil, data != nil {
                let decoder = JSONDecoder()
                do {
                    let parsingData = try decoder.decode(MainResponseModel.self, from: data!)
                    self.totalPage = parsingData.totalPage ?? 1
                    self.dataArray.append(contentsOf: parsingData.data!)
                    print("Cities Count = \(self.dataArray.count)")
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch {
                    print("⭕️⭕️⭕️ PARSING ERROR")
                }
            }
        }
        dataTask.resume()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if currentPage < totalPage && indexPath.row == dataArray.count - 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "loading")
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            let data = dataArray[indexPath.row]
            cell.textLabel?.text = data.province
            cell.accessoryType = .detailDisclosureButton
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if currentPage < totalPage && indexPath.row == dataArray.count - 1 {
            currentPage = currentPage + 1
            fetchData(pageNum: currentPage, refresh: false)
        }
    }
}
