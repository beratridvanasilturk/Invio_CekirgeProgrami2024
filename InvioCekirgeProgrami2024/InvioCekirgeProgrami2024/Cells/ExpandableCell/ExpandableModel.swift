//
//  ExpandableModel.swift
//  InvioCekirgeProgrami2024
//
//  Created by Berat Ridvan Asilturk on 17.04.2024.
//

import Foundation
import SafariServices

// Presentation Model
struct ExpandableCellContentModel {
    var hideContent: Bool
    let universityModel: UniversitiesResponseModel
    
    init(hideContent: Bool = true, universityModel: UniversitiesResponseModel) {
        self.hideContent = hideContent
        self.universityModel = universityModel
    }
}

final class ExpandableModel {
    
    func formatPhoneNumber(_ input: String) -> String? {
        
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
    
    func openURLInSafariSheet(urlString: String, from viewController: UIViewController) {
        guard urlString.count >= 10 else {
            print("Invalid URL")
            return
        }
        
        let secureURLString = checkUrlForHttps(urlString)
        
        if let url = URL(string: secureURLString) {
            let safariViewController = SFSafariViewController(url: url)
            
            safariViewController.modalPresentationStyle = .pageSheet
            
            viewController.present(safariViewController, animated: true, completion: nil)
        }
    }
    
    private func checkUrlForHttps(_ urlString: String) -> String {
        // Hakkari universitesinde backend'den gelen tek string icerisindeki 2 farkli url icin kod duzenlemesi
        let parts = urlString.split(separator: " ", maxSplits: 1)
        
        // ilk url string'i kabul eder
        let trimmedUrlString = String(parts[0])
        
        // "Https:" varligini kontrol eder
        if trimmedUrlString.hasPrefix("https://") {
            return trimmedUrlString
        } else {
            return "https://\(trimmedUrlString)"
        }
    }
}
