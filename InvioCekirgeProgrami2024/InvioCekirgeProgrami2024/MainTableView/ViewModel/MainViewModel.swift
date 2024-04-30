//
//  MainViewModel.swift
//  InvioCekirgeProgrami2024
//
//  Created by Berat Ridvan Asilturk on 12.04.2024.
//

import UIKit

final class MainViewModel {
    
    // MARK: - Props
    private var totalPage = 1
    private var currentPage = 1
    private (set) var sections: [SectionModel] = []
    private let reachability = Reachability()
    
    // MARK: - Funcs
    func fetchData(updatePage: Bool = false, completion: @escaping (Bool) -> Void) {
        
        if updatePage {
            currentPage += 1
        }
        
        let baseUrlString = "https://storage.googleapis.com/invio-com/usg-challenge/universities-at-turkey/"
        let urlString = baseUrlString + "page-\(currentPage).json"
        
        guard reachability.isConnectedToNetwork() else {
            completion(false)
            return
        }
        
        if let url = URL(string: urlString) {
            
            let session = URLSession.shared
            let dataTask = session.dataTask(with: url) { data, response, error in
                
                guard error == nil else {
                    print("⚠️⚠️⚠️ FETCDATA ERROR:")
                    print(error?.localizedDescription ?? "Tanimlanamayan Fetching Hatasi")
                    completion(false) // Fetch işlemi başarısız
                    return
                }
                
                guard let data = data else {
                    completion(false) // Fetch işlemi başarısız
                    return
                }
                
                var dataArray = [DataResponseModel]()
                let decoder = JSONDecoder()
                
                do {
                    let responseModel = try decoder.decode(MainResponseModel.self, from: data)
                    self.totalPage = responseModel.totalPage ?? 1
                    if let parsingData = responseModel.data {
                        dataArray.append(contentsOf: parsingData)
                    }
                    
                    // Sectionları doldururuz
                    dataArray.forEach { dataModel in
                        
                        var contentList = [ExpandableCellContentModel]()
                        
                        dataModel.universities?.forEach({ model in
                            let contentModel = ExpandableCellContentModel(universityModel: model)
                            contentList.append(contentModel)
                        })
                        
                        let sectionItem = SectionModel(dataModel: dataModel, contentList: contentList)
                        self.sections.append(sectionItem)
                    }
                    
                    print("🟡🟡🟡 Cities Count = \(self.sections.count)")
                    
                    completion(true) // Fetch işlemi başarılı
                    
                } catch(let err) {
                    print("⭕️⭕️⭕️ PARSING ERROR \(err.localizedDescription)")
                    completion(false) // Fetch işlemi başarısız
                }
            }
            dataTask.resume()
        } else {
            print("😵😵😵 URL ERROR")
            completion(false) // Fetch işlemi başarısız
        }
    }
    
    func closeExpandedCells() {
        // Sections Close
        for sectionIndex in 0..<sections.count {
            sections[sectionIndex].hideContent = true
            
            // Expanded Cells Close
            for contentIndex in 0..<sections[sectionIndex].contentList.count {
                sections[sectionIndex].contentList[contentIndex].hideContent = true
            }
        }
    }
    
    func resetContent() {
        currentPage = 1
        sections.removeAll()
    }
    
    func sectionSelected(indexPath: IndexPath) {
        sections[indexPath.section].hideContent = !sections[indexPath.section].hideContent
    }
    
    func contentSelected(indexPath: IndexPath) {
        sections[indexPath.section].contentList[indexPath.row - 1].hideContent.toggle()
    }
    
    func paginationFlag(indexPath: IndexPath) -> Bool {
        currentPage < totalPage && indexPath.section == sections.count - 1
    }
}
