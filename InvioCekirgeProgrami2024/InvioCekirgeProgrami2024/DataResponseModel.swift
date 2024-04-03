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

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case province = "province"
        case universities = "universities"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        province = try values.decodeIfPresent(String.self, forKey: .province)
        universities = try values.decodeIfPresent([UniversitiesResponseModel].self, forKey: .universities)
    }

}
