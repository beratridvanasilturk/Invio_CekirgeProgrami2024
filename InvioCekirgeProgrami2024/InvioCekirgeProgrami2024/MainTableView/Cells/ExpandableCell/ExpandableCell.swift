//
//  ExpantableCell.swift
//  InvioCekirgeProgrami2024
//
//  Created by Berat Ridvan Asilturk on 12.04.2024.
//

import UIKit

class ExpandableCell: UITableViewCell {
    
    static let cellIdentifier = String(describing: ExpandableCell.self)


    
    
    
    @IBOutlet weak var expendStackView: UIStackView!
    
    @IBOutlet weak var label: UILabel!
    
    var model: ExpandableCellContentModel? {
        didSet {
            label.text = model?.universityModel.name
            expendStackView.isHidden = model?.hideContent ?? false
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func firstSetup() {
        expendStackView.isHidden = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
    }

}

    


