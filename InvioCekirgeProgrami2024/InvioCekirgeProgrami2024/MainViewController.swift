//
//  ViewController.swift
//  InvioCekirgeProgrami2024
//
//  Created by Berat Ridvan Asilturk on 3.04.2024.
//

import UIKit

class MainViewController: UITableViewController {
    
    let cellIdentifier = "cellIdentifier"
    let taskUrl = "https://storage.googleapis.com/invio-com/usg-challenge/universities-at-turkey/page-1.json"
    var dataArray = [DataResponseModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parsingJson { data in
            self.dataArray = data
        }
    }
    
    func parsingJson(completion: @escaping ([DataResponseModel]) -> Void) {
        let urlString = "https://storage.googleapis.com/invio-com/usg-challenge/universities-at-turkey/page-1.json"
        let url = URL(string: urlString)
        
        guard url != nil else {
            print("😵😵😵 URL ERROR")
            return
        }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { data, response, error in
            
            if error == nil, data != nil {
                
                let decoder = JSONDecoder()
                do {
                    let parsingData = try decoder.decode(MainResponseModel.self, from: data!)
                    completion(parsingData.data!)
                    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let data = dataArray[indexPath.row]
        cell.textLabel?.text = data.province
        cell.accessoryType = .detailDisclosureButton
        return cell
    }
}
