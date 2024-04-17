//
//  PersistentManager.swift
//  InvioCekirgeProgrami2024
//
//  Created by Berat Ridvan Asilturk on 18.04.2024.
//

import Foundation
import RealmSwift

// MARK: - Persistent Manager
class FavoriModel: Object {
    @Persisted var name: String?
    @Persisted var phone: String?
    @Persisted var fax: String?
    @Persisted var website: String?
    @Persisted var email: String?
    @Persisted var adress: String?
    @Persisted var rector: String?
}

// MARK: - Persistent Model
class PersistentManager {
    static let shared = PersistentManager()
    
    private let realm = try! Realm()
    
    func addFavorites(item: UniversitiesResponseModel) {
        
        let favoriModel = FavoriModel()
        
        favoriModel.name = item.name
        favoriModel.phone = item.phone
        favoriModel.fax = item.fax
        favoriModel.website = item.website
        favoriModel.email = item.email
        favoriModel.adress = item.adress
        favoriModel.rector = item.rector
        
        
        try! realm.write{
            realm.add(favoriModel)
        }
    }
    
    func getFavorites() -> [UniversitiesResponseModel] {
        let favorites = realm.objects(FavoriModel.self)
        
        let universities = favorites.map { favoriModel in
            
            UniversitiesResponseModel(
                name: favoriModel.name,
                phone: favoriModel.phone,
                fax: favoriModel.fax,
                website:favoriModel.website,
                email: favoriModel.email,
                adress: favoriModel.adress,
                rector: favoriModel.rector
            )
        }
            return Array(universities)
    }
}