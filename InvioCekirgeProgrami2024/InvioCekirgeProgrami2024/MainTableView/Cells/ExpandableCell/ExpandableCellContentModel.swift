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
}

struct Section {
    var dataModel: DataResponseModel
    var hideContent: Bool
    var contentList: [ExpandableCellContentModel]
    
}
