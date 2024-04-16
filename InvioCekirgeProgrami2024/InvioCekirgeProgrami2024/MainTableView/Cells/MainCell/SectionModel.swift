//
//  ExpandableCellContentModel.swift
//  InvioCekirgeProgrami2024
//
//  Created by Berat Ridvan Asilturk on 12.04.2024.
//

import Foundation

// Presentation Model
struct SectionModel {
    var hideContent: Bool
    var dataModel: DataResponseModel
    var contentList: [ExpandableCellContentModel]
    
    init(hideContent: Bool = true, dataModel: DataResponseModel, contentList: [ExpandableCellContentModel]) {
        self.dataModel = dataModel
        self.hideContent = hideContent
        self.contentList = contentList
    }
    
}
