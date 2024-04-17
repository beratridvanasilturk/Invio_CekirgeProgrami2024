//
//  MainCell.swift
//  InvioCekirgeProgrami2024
//
//  Created by Berat Ridvan Asilturk on 12.04.2024.
//

import UIKit

class MainCell: UITableViewCell {
    static let cellIdentifier = String(describing: MainCell.self)

    @IBOutlet private weak var label: UILabel!
    
    var title: String? {
        didSet {
            label.text = title
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
