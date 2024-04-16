//
//  Array+Extensions.swift
//  InvioCekirgeProgrami2024
//
//  Created by Berat Ridvan Asilturk on 16.04.2024.
//

import Foundation

extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
