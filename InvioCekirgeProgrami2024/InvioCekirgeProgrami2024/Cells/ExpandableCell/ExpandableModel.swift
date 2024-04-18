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
            // `viewController` üzerinde `safariViewController`'ı modal olarak sunar
            viewController.present(safariViewController, animated: true, completion: nil)
        }
    }
    
    private func checkUrlForHttps(_ urlString: String) -> String {
        if urlString.hasPrefix("https://") {
            return urlString
        } else {
            return "https://\(urlString)"
        }
    }
}
