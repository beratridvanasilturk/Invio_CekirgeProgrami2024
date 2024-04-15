//
//  MainViewModel.swift
//  InvioCekirgeProgrami2024
//
//  Created by Berat Ridvan Asilturk on 12.04.2024.
//

import Foundation

final class MainViewModel {
    
    var dataArray = [DataResponseModel]()
    var totalPage = 1
    var currentPage = 1 
    
    var sections: [Section] = []
        
    func fetchData(pageNum: Int, completion: (() -> Void)? = nil) {
        
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
                
                print("🟡🟡🟡 Cities Count = \(self.dataArray.count)")
                
                // Sectionlari doldururuz
                self.dataArray.forEach { dataModel in
                    
                    var contentList = [ExpandableCellContentModel]()
                    
                    dataModel.universities?.forEach({ model in
                        let contentModel = ExpandableCellContentModel(hideContent: true, universityModel: model)
                        contentList.append(contentModel)
                    })
                    
                    let sectionItem = Section(dataModel: dataModel, hideContent: true, contentList: contentList)
                    self.sections.append(sectionItem)
                }
               
                completion?()
                
            } catch(let err) {
                print("⭕️⭕️⭕️ PARSING ERROR \(err.localizedDescription)")
            }
        }
        dataTask.resume()
    }
}
