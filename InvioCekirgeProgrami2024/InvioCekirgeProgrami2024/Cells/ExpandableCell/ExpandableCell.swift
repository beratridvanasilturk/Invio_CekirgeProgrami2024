//
//  ExpantableCell.swift
//  InvioCekirgeProgrami2024
//
//  Created by Berat Ridvan Asilturk on 12.04.2024.
//

import UIKit

final class ExpandableCell: UITableViewCell {
    // MARK: - Props
    private let viewModel = ExpandableModel()
    static let cellIdentifier = String(describing: ExpandableCell.self)
    
    // MARK: - Outlets
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // MARK: - Funcs
    private func firstSetup() {
        phoneLabel.isUserInteractionEnabled = true
        websiteLabel.isUserInteractionEnabled = true
        
        phoneLabel?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(phoneButtonTapped)))
        
        websiteLabel?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(websiteButtonTapped)))
    }
    
    private func findParentViewController() -> UIViewController? {
        // Kendini bir sonraki akran nesneye döndürerek ve sınıfını kontrol ederek gezinme islemi
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder?.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    // Backendden gelen dataya gore tel no'yu yeniden duzenler, aranabilecek seviyeye getirir.
    private func makePhoneCall(to phoneNumber: String) {
        var formattedNumber = phoneNumber.replacingOccurrences(of: "+", with: "")
        
        // Telefon numarası başında 0 rakamı yoksa, başına 0 ekler
        // Orn: Trabzon Avrasya Universitesi Basinda Sifir Eksik
          if !formattedNumber.hasPrefix("0") {
              formattedNumber = "0" + formattedNumber
          }
          
        // Fazlalık olan haneleri siler
        if formattedNumber.count > 11 {
            formattedNumber = String(formattedNumber.prefix(11))
        }
        
        if let phoneURL = URL(string: "tel://\(formattedNumber)") {
            if UIApplication.shared.canOpenURL(phoneURL) {
                UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
                print("☎️☎️☎️ Successful Phone Call Forwarding")
            }
        }
    }
    
    @objc private func phoneButtonTapped() {
        if let phone = model?.universityModel.phone{
            if let phoneNumber = viewModel.formatPhoneNumber(phone) {
                makePhoneCall(to: phoneNumber)
            }
        }
    }
    
    @objc private func websiteButtonTapped() {
        if let website = model?.universityModel.website{
            if let viewController = self.findParentViewController() {
                viewModel.openURLInSafariSheet(urlString: website, from: viewController)
            }
        }
    }
    
    // MARK: Actions
    @IBAction private func favButtonTapped() {
        if let universityModel = model?.universityModel {
            PersistentManager.shared.checkFavorites(item: universityModel)
            print("♥️♥️♥️ Fav Button Tapped")
        }
    }
}
