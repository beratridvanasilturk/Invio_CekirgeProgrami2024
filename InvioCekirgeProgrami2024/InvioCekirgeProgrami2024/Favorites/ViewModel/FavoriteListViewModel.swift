//
//  FavListViewModel.swift
//  InvioCekirgeProgrami2024
//
//  Created by Berat Ridvan Asilturk on 18.04.2024.
//

import Foundation

final class FavoriteListViewModel {
    var favList = PersistentManager.shared.getFavorites()
    
    func updateModel() {
        favList = PersistentManager.shared.getFavorites()
    }
}
