//
//  MainCell.swift
//  InvioCekirgeProgrami2024
//
//  Created by Berat Ridvan Asilturk on 12.04.2024.
//

import UIKit

class MainCell: UITableViewCell {
    // MARK: - Props
    static let cellIdentifier = String(describing: MainCell.self)
    
    // MARK: - Outlest
    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var iconLabel: UILabel!
    
    var model: SectionModel? {
        didSet {
            label.text = model?.dataModel.province
            iconLabel.text = (model?.hideContent ?? false) ? "+" : "-"
//            iconLabel.isHidden =  model?.contentList.isEmpty ?? false
            if model?.contentList.isEmpty == true {
                iconLabel.text = " "
            }
        }
    }
}
