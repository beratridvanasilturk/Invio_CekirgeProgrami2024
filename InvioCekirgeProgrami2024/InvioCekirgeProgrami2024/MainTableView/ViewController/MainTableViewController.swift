//
//  ViewController.swift
//  InvioCekirgeProgrami2024
//
//  Created by Berat Ridvan Asilturk on 3.04.2024.
//

// TODO: - Classlar final
// Parametleler ve methodlar private // encapsulation
// MVVM cevir
// OPTIONAL KURTUL
// KLASORLE
// Favoriler Realm
// Printler kaldirilabilir proje tesliminde
// DidLoad Refactor Edilecek

import UIKit

final class MainTableViewController: UITableViewController {
    
    private let cellIdentifier = "cellIdentifier"
    private var dataArray = [DataResponseModel]()
    private var totalPage = 1
    private var currentPage = 1
    private var refresh = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadDatas()
        
    }
    
    private func fetchData(pageNum: Int) {
        
        checkRefreshing()
        
        let baseUrlString = "https://storage.googleapis.com/invio-com/usg-challenge/universities-at-turkey/"
        let urlString = baseUrlString + "page-\(pageNum).json"
        
        guard let url = URL(string: urlString) else {
            print("😵😵😵 URL ERROR")
            return
        }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { data, response, error in
            
            guard error == nil else {
                print(error?.localizedDescription)
                return
            }
            
            guard let data = data else {
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let responseModel = try decoder.decode(MainResponseModel.self, from: data)
                self.totalPage = responseModel.totalPage ?? 1
                if let parsingData = responseModel.data {
                    self.dataArray.append(contentsOf: parsingData)
                }
                
                print("Cities Count = \(self.dataArray.count)")
               
                reloadData()
                
            } catch(let err) {
                print("⭕️⭕️⭕️ PARSING ERROR \(err.localizedDescription)")
            }
        }
        dataTask.resume()
        
        func checkRefreshing() {
            DispatchQueue.main.async {
                if self.refresh {
                    self.refreshControl?.beginRefreshing()
                    self.dataArray.removeAll()
                    self.refreshControl?.endRefreshing()
                    self.refresh.toggle()
                    print("🔄🔄🔄 Refreshed")
                }
            }
        }
        
        func reloadData() {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
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
            return cell
        }
    }
    
    // Pagination / Sayfalama
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if currentPage < totalPage && indexPath.row == dataArray.count - 1 {
            currentPage = currentPage + 1
            fetchData(pageNum: currentPage)
        }
    }
    
    private func loadDatas() {

        fetchData(pageNum: currentPage)
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    @objc private func refreshData() {
        currentPage = 1
        refresh = true
        fetchData(pageNum: currentPage)
    }
    
}
