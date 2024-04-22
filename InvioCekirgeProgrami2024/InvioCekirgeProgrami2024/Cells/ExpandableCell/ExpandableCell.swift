//
//  ExpantableCell.swift
//  InvioCekirgeProgrami2024
//
//  Created by Berat Ridvan Asilturk on 12.04.2024.
//

import UIKit
import WebKit

final class ExpandableCell: UITableViewCell {
    // MARK: - Props
    private var goBack: (() -> Void)?
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
    @IBOutlet weak var iconLabel: UILabel!
    
    /// Icerigi kontrol eder, model de name harici herhangi bir data yoksa, expandable stack gizlenmesi icin kullanilir.
    func iconLabelWillHide() -> Bool {
        var controllFlag = false
        
        if model?.universityModel.phone == "-" { controllFlag = true }
        if model?.universityModel.fax == "-" { controllFlag = true }
        if model?.universityModel.website == "-" { controllFlag = true }
        if model?.universityModel.email == "-" { controllFlag = true }
        if model?.universityModel.adress == "-" { controllFlag = true }
        if model?.universityModel.rector == "-" { controllFlag = true }
        
        return controllFlag
    }

    var model: ExpandableCellContentModel? {
        didSet {
            label.text = model?.universityModel.name
            phoneLabel?.text = "Telefon: " + (model?.universityModel.phone ?? "Bulunamadı")
            faxLabel?.text = "Fax: " + (model?.universityModel.fax  ?? "Bulunamadı")
            websiteLabel?.text = "Website: " + (model?.universityModel.website ?? "Bulunamadı")
            adressLabel?.text = "Adres: " + (model?.universityModel.adress ?? "Bulunamadı")
            rectorLabel?.text = "Rektör: " + (model?.universityModel.rector ?? "Bulunamadı")
            
            let image = PersistentManager.shared.isFavorited(item: model?.universityModel) ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
            
            favoriteButton.setImage(image, for: .normal)
            
            iconLabel.text = (model?.hideContent ?? false) ? "+" : "-"
            
            if iconLabelWillHide() {
                iconLabel.text = ""
                expendStackView.isHidden = true
            } else {
                expendStackView.isHidden = model?.hideContent ?? false
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        firstSetup()
    }
    
    // MARK: - Funcs
    private func firstSetup() {
        phoneLabel.isUserInteractionEnabled = true
        websiteLabel.isUserInteractionEnabled = true
        
        phoneLabel?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(phoneButtonTapped)))
        
        websiteLabel?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(websiteButtonTapped)))
    }
    
    // Safari Sheet Icin Kullanildi
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
        // Orn: TcheckFavListEmptyrabzon Avrasya Universitesi Basinda Sifir Eksik
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
            if let phoneNumber = formatPhoneNumber(phone) {
                makePhoneCall(to: phoneNumber)
            }
        }
    }
    
    @objc private func websiteButtonTapped() {
        if let website = model?.universityModel.website{
            if let viewController = self.findParentViewController() {
                openURLInWebView(urlString: website, from: viewController)
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
    
    //MARK: - Helpers
    private func formatPhoneNumber(_ input: String) -> String? {
        
        let digits = input.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        
        guard digits.count >= 10 else {
            print("Invalid Phone Number")
            return nil
        }
        let countryCode = "+\(digits.prefix(1))"
        let localNumber = digits.dropFirst()
        let formattedPhoneNumber = "\(countryCode)\(localNumber)"
        
        return formattedPhoneNumber
    }
    
    private func openURLInWebView(urlString: String, from viewController: UIViewController) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        let webView = WKWebView(frame: UIScreen.main.bounds)
        let request = URLRequest(url: url)
        webView.load(request)
        
        let webViewController = UIViewController()
        webViewController.view.addSubview(webView)
        webViewController.title = model?.universityModel.name
        
        let backButton = UIBarButtonItem(title: "Geri", style: .plain, target: self, action: #selector(goBackAction))
        
        webViewController.navigationItem.leftBarButtonItem = backButton
        
        let navigationController = UINavigationController(rootViewController: webViewController)
        viewController.present(navigationController, animated: true, completion: nil)
        
        // UITableViewCell sinifi icerisinden navigate'e erisemedigimiz icin closure olarak tanimladik
        goBack = {
            webViewController.dismiss(animated: true, completion: nil)
        }
    }

    @objc private func goBackAction() {
        goBack?()
    }
    
    private func checkUrlForHttps(_ urlString: String) -> String {
        // Backend'den gelen string icerisindeki 2 farkli url icin kod duzenlemesi
        // Orn: Hakkari Universitesi
        let parts = urlString.split(separator: " ", maxSplits: 1)
        // ilk url string'i kabul eder, devamini isleme almayiz
        let trimmedUrlString = String(parts[0])
        // "Https:" varligini kontrol eder
        if trimmedUrlString.hasPrefix("https://") {
            return trimmedUrlString
        } else {
            return "https://\(trimmedUrlString)"
        }
    }
}
