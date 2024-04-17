//
//  ExpandableModel.swift
//  InvioCekirgeProgrami2024
//
//  Created by Berat Ridvan Asilturk on 17.04.2024.
//

import Foundation

// Presentation Model
struct ExpandableCellContentModel {
    var hideContent: Bool
    let universityModel: UniversitiesResponseModel
    
    init(hideContent: Bool = true, universityModel: UniversitiesResponseModel) {
        self.hideContent = hideContent
        self.universityModel = universityModel
    }
}
