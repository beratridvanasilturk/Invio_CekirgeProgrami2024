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

    enum CodingKeys: String, CodingKey {

        case currentPage = "currentPage"
        case totalPage = "totalPage"
        case total = "total"
        case itemPerPage = "itemPerPage"
        case pageSize = "pageSize"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        currentPage = try values.decodeIfPresent(Int.self, forKey: .currentPage)
        totalPage = try values.decodeIfPresent(Int.self, forKey: .totalPage)
        total = try values.decodeIfPresent(Int.self, forKey: .total)
        itemPerPage = try values.decodeIfPresent(Int.self, forKey: .itemPerPage)
        pageSize = try values.decodeIfPresent(Int.self, forKey: .pageSize)
        data = try values.decodeIfPresent([DataResponseModel].self, forKey: .data)
    }

}


