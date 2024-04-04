////
////  APICaller.swift
////  InvioCekirgeProgrami2024
////
////  Created by Berat Ridvan Asilturk on 4.04.2024.
////
//
//import Foundation
//
//class APICaller {
//    
//    func parsingJson(refreshed: Bool = false, completion: @escaping ([DataResponseModel]) -> Void) {
//        
//        if refreshed {
//            MainViewController.refresh
//        }
//            
//            let urlString = "https://storage.googleapis.com/invio-com/usg-challenge/universities-at-turkey/page-1.json"
//            let url = URL(string: urlString)
//            
//            guard url != nil else {
//                print("😵😵😵 URL ERROR")
//                return
//            }
//            
//            let session = URLSession.shared
//            let dataTask = session.dataTask(with: url!) { data, response, error in
//                
//                if error == nil, data != nil {
//                    
//                    let decoder = JSONDecoder()
//                    do {
//                        let parsingData = try decoder.decode(MainResponseModel.self, from: data!)
//                        completion(parsingData.data!)
//                    } catch {
//                        print("⭕️⭕️⭕️ PARSING ERROR")
//                    }
//                }
//            }
//            dataTask.resume()
//        }
//}
