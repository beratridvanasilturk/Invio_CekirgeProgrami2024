//
//  MainViewModel.swift
//  InvioCekirgeProgrami2024
//
//  Created by Berat Ridvan Asilturk on 12.04.2024.
//

import Foundation

final class MainViewModel {
    
    private var totalPage = 1
    private var currentPage = 1
    
    private (set) var sections: [Section] = []
    
    func fetchData(completion: (() -> Void)? = nil, updatePage: Bool = false) {
        
        if updatePage {
            currentPage += 1
        }
        
        let baseUrlString = "https://storage.googleapis.com/invio-com/usg-challenge/universities-at-turkey/"
        let urlString = baseUrlString + "page-\(currentPage).json"
        
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
            
            var dataArray = [DataResponseModel]()
            let decoder = JSONDecoder()
            
            do {
                let responseModel = try decoder.decode(MainResponseModel.self, from: data)
                self.totalPage = responseModel.totalPage ?? 1
                if let parsingData = responseModel.data {
                    dataArray.append(contentsOf: parsingData)
                }
                
                print("🟡🟡🟡 Cities Count = \(dataArray.count)")
                
                // Sectionlari doldururuz
                dataArray.forEach { dataModel in
                    
                    var contentList = [ExpandableCellContentModel]()
                    
                    dataModel.universities?.forEach({ model in
                        let contentModel = ExpandableCellContentModel(universityModel: model)
                        contentList.append(contentModel)
                    })
                    
                    let sectionItem = Section(dataModel: dataModel, contentList: contentList)
                    self.sections.append(sectionItem)
                }
                
                completion?()
                
            } catch(let err) {
                print("⭕️⭕️⭕️ PARSING ERROR \(err.localizedDescription)")
            }
        }
        dataTask.resume()
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
    
    func sectionSelected(sectionIndex: Int) {
        sections[sectionIndex].hideContent = !sections[sectionIndex].hideContent
    }
    
    func contentSelected(sectionIndex: Int, contentIndex: Int) {
        sections[sectionIndex].contentList[contentIndex - 1].hideContent.toggle()
    }
    
    func paginationFlag(indexPath: IndexPath) -> Bool {
        currentPage < totalPage && indexPath.row == sections.count - 1
    }
}
