//
//  SplashViewController.swift
//  InvioCekirgeProgrami2024
//
//  Created by Berat Ridvan Asilturk on 19.04.2024.
//

import UIKit

final class SplashViewController: UIViewController {
    
    // MARK: - LifeCylce
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    // MARK: - Funcs
    private func getData() {
        let viewModel = MainViewModel()
        viewModel.fetchData(updatePage: false) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.navigateToMainScreen(viewModel: viewModel)
            }
        }
    }
    
    private func navigateToMainScreen(viewModel: MainViewModel) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController else {
            return
        }
        mainViewController.viewModel = viewModel
        let navigationController = UINavigationController(rootViewController: mainViewController)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: false, completion: nil)
    }
}
