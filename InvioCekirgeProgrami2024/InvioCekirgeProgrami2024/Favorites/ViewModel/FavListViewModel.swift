//
//  FavListViewModel.swift
//  InvioCekirgeProgrami2024
//
//  Created by Berat Ridvan Asilturk on 18.04.2024.
//

import Foundation

class FavListViewModel {
    var favList = PersistentManager.shared.getFavorites()
}
