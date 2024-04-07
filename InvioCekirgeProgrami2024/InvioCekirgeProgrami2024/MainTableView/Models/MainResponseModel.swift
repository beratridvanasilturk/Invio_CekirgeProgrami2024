//
//  MainResponseModel.swift
//  InvioCekirgeProgrami2024
//
//  Created by Berat Ridvan Asilturk on 3.04.2024.
//

import Foundation

struct MainResponseModel: Codable {
    let currentPage: Int?
    let totalPage: Int?
    let total: Int?
    let itemPerPage: Int?
    let pageSize: Int?
    let data: [DataResponseModel]?
}


