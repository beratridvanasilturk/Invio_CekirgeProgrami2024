//
//  SplashViewController.swift
//  InvioCekirgeProgrami2024
//
//  Created by Berat Ridvan Asilturk on 19.04.2024.
//

//TODO: - Landscape Modu Icin Ekran Constraints Check Edilecek

import UIKit

final class SplashViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var emptyView: EmptyAnimationView!
    // MARK: - Props
    private var badInternetConnection = false
    private let viewModel = MainViewModel()
    
    // MARK: - LifeCylce
    override func viewDidLoad() {
        super.viewDidLoad()
        checkInternet()
        getData()
    }
    
    // MARK: - Funcs
    private func getData() {
        viewModel.fetchData(updatePage: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                guard !self.badInternetConnection else {
                    return
                }
                self.transitionToMainScreen()
            }
        }
    }
    
    private func transitionToMainScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController else {
            return
        }
        mainViewController.modalPresentationStyle = .fullScreen
        self.present(mainViewController, animated: false, completion: nil)
    }
    
    private func checkInternet() {
        viewModel.checkInternetConnection { isConnected in
            if !isConnected {
                self.emptyView.startFailAnimation()
                self.badInternetConnection = true
                self.viewModel.showAlertForNoInternetConnection(in: self)
            } else {
                self.emptyView.startSuccessAnimation()
                self.badInternetConnection = false
            }
        }
    }
}
