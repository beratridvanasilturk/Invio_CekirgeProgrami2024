//
//  ExpandableCellContentModel.swift
//  InvioCekirgeProgrami2024
//
//  Created by Berat Ridvan Asilturk on 12.04.2024.
//

import Foundation

struct ExpandableCellContentModel {
    let title: String
    var hideContent: Bool
}

struct Section {
    var dataModel: DataResponseModel?
    var mainCellTitle: String
    var hideContent: Bool
    var contentList: [ExpandableCellContentModel]
}
