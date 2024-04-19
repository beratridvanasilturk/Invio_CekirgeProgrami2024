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
    
    var title: String? {
        didSet {
            label.text = title
        }
    }
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }
}
