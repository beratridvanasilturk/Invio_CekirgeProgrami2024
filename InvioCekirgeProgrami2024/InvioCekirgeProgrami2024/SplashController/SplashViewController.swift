//
//  SplashViewController.swift
//  InvioCekirgeProgrami2024
//
//  Created by Berat Ridvan Asilturk on 19.04.2024.
//

import UIKit

final class SplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchDataForFirstPage() { success in
            if success {
                DispatchQueue.main.async {
                    
                    print("🟢🟢🟢 Splash Ekrani Veri Cekme Basarili, Ana Ekrana Aktariliyor...")
                    self.transitionToMainScreen()
                }
            } else {
                DispatchQueue.main.async {
                    self.showErrorAndStayOnLaunchScreen()
                }
            }
        }
    }
    
    private func fetchDataForFirstPage(completion: @escaping (Bool) -> Void) {
        
        let urlString = "https://storage.googleapis.com/invio-com/usg-challenge/universities-at-turkey/page-1.json"
        
        if let url = URL(string: urlString) {
            let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("🔴🔴🔴 Splash Ekrani Veri Cekme Hatası: \(error)")
                    completion(false)
                    return
                }
                completion(true)
            }
            dataTask.resume()
        }
    }
    
    private func transitionToMainScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController")
        mainViewController.modalPresentationStyle = .fullScreen
        present(mainViewController, animated: true, completion: nil)
    }
    
    private func showErrorAndStayOnLaunchScreen() {
        let alert = UIAlertController(title: "Hata", message: "Veri çekme işlemi başarısız oldu.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
