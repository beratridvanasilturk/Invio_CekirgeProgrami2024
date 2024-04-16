//
//  DataResponseModel.swift
//  InvioCekirgeProgrami2024
//
//  Created by Berat Ridvan Asilturk on 3.04.2024.
//

import Foundation

struct DataResponseModel: Codable {
    let id: Int?
    let province: String?
    let universities: [UniversitiesResponseModel]?
}
