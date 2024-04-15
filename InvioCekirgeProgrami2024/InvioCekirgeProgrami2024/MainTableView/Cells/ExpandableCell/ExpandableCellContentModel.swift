//
//  ExpandableCellContentModel.swift
//  InvioCekirgeProgrami2024
//
//  Created by Berat Ridvan Asilturk on 12.04.2024.
//

import Foundation

struct ExpandableCellContentModel {
    var hideContent: Bool
    let universityModel: UniversitiesResponseModel
    
    init(hideContent: Bool = true, universityModel: UniversitiesResponseModel) {
        self.hideContent = hideContent
        self.universityModel = universityModel
    }
}

struct Section {
    var hideContent: Bool
    var dataModel: DataResponseModel
    var contentList: [ExpandableCellContentModel]
    
    init(hideContent: Bool = true, dataModel: DataResponseModel, contentList: [ExpandableCellContentModel]) {
        self.dataModel = dataModel
        self.hideContent = hideContent
        self.contentList = contentList
    }
    
}
