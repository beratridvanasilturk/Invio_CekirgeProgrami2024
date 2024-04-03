//
//  UniversitiesResponseModel.swift
//  InvioCekirgeProgrami2024
//
//  Created by Berat Ridvan Asilturk on 3.04.2024.
//

import Foundation

struct UniversitiesResponseModel: Codable {
    let name: String?
    let phone: String?
    let fax: String?
    let website: String?
    let email: String?
    let adress: String?
    let rector: String?

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case phone = "phone"
        case fax = "fax"
        case website = "website"
        case email = "email"
        case adress = "adress"
        case rector = "rector"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        fax = try values.decodeIfPresent(String.self, forKey: .fax)
        website = try values.decodeIfPresent(String.self, forKey: .website)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        adress = try values.decodeIfPresent(String.self, forKey: .adress)
        rector = try values.decodeIfPresent(String.self, forKey: .rector)
    }

}
