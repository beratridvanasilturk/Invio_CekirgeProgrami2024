////
////  abc.swift
////  InvioCekirgeProgrami2024
////
////  Created by Berat Ridvan Asilturk on 12.04.2024.
////
//
//import Foundation
//
//class Abc {
//    
//    let main = MainTableViewController()
//     func fetchData(pageNum: Int, refresh: Bool = false) {
//        
//        checkRefreshing()
//        
//        let baseUrlString = "https://storage.googleapis.com/invio-com/usg-challenge/universities-at-turkey/"
//        let urlString = baseUrlString + "page-\(pageNum).json"
//        
//        guard let url = URL(string: urlString) else {
//            print("😵😵😵 URL ERROR")
//            return
//        }
//        
//        let session = URLSession.shared
//        let dataTask = session.dataTask(with: url) { data, response, error in
//            
//            guard error == nil else {
//                print(error?.localizedDescription)
//                return
//            }
//            
//            guard let data = data else {
//                return
//            }
//            
//            let decoder = JSONDecoder()
//            
//            do {
//                let responseModel = try decoder.decode(MainResponseModel.self, from: data)
//                
//                DispatchQueue.main.async {
//                    
//                    self.main.totalPage = responseModel.totalPage ?? 1
//                    if let parsingData = responseModel.data {
//                        MainTableViewController().dataArray.append(contentsOf: parsingData)
//                    }
//                    
//                }
////                print("Cities Count = \(MainTableViewController().dataArray.count)")
//                DispatchQueue.main.async {
//                    self.main.reloadData()
//                }
//                
//            } catch(let err) {
//                print("⭕️⭕️⭕️ PARSING ERROR \(err.localizedDescription)")
//            }
//        }
//        dataTask.resume()
//        
//        func checkRefreshing() {
//            DispatchQueue.main.async {
//                if refresh {
//                    self.main.refreshControl?.beginRefreshing()
//                    self.main.dataArray.removeAll()
//                    self.main.refreshControl?.endRefreshing()
//                    print("🔄🔄🔄 Refreshed")
//                }
//            }
//        }
//        
//       
//    }
//}
