//
//  ExpantableCell.swift
//  InvioCekirgeProgrami2024
//
//  Created by Berat Ridvan Asilturk on 12.04.2024.
//

// TODO: Phone Call Need Add for Phone Tapped Func

import UIKit

class ExpandableCell: UITableViewCell {
    
    static let cellIdentifier = String(describing: ExpandableCell.self)
    
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var faxLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var rectorLabel: UILabel!
    @IBOutlet weak var expendStackView: UIStackView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBOutlet weak var label: UILabel!
    
    var model: ExpandableCellContentModel? {
        didSet {
            label.text = model?.universityModel.name
            expendStackView.isHidden = model?.hideContent ?? false
            phoneLabel?.text = "Telefon: " + (model?.universityModel.phone ?? "Bulunamadı")
            faxLabel?.text = "Fax: " + (model?.universityModel.fax  ?? "Bulunamadı")
            websiteLabel?.text = "Website: " + (model?.universityModel.website ?? "Bulunamadı")
            adressLabel?.text = "Adres: " + (model?.universityModel.adress ?? "Bulunamadı")
            rectorLabel?.text = "Rektör: " + (model?.universityModel.rector ?? "Bulunamadı")
            
            let image = PersistentManager.shared.isFavorited(item: model?.universityModel) ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
            
            favoriteButton.setImage(image, for: .normal)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        firstSetup()
    }

    func firstSetup() {
        phoneLabel.isUserInteractionEnabled = true
        phoneLabel?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(phoneButtonTapped)))
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    @objc func phoneButtonTapped() {
        if let phone = model?.universityModel.phone, !phone.isEmpty {
            print("Phone Tapped 😢😢😢😢😢😢😢😢")
            // TODO: Phone Call Need Add
        }
    }
    
    @IBAction func favButtonTapped() {
        if let universityModel = model?.universityModel {
            PersistentManager.shared.checkFavorites(item: universityModel)
            print("♥️♥️♥️ Fav Button Tapped")
        }
    }
}

    


