//
//  SplashViewController.swift
//  InvioCekirgeProgrami2024
//
//  Created by Berat Ridvan Asilturk on 19.04.2024.
//

import UIKit
//import Lottie

//TODO: - Landscape Modu Icin Ekran Constraints Check Edilecek

final class SplashViewController: UIViewController {
    
    // MARK: - Outlets
//    @IBOutlet weak var invioImageView: UIImageView!
    // MARK: - Props

//    private var animationView: LottieAnimationView?
//    private let animationWidth: CGFloat = 180
//    private let animationHeight: CGFloat = 180
    
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
                self.transitionToMainScreen(viewModel: viewModel)
            }
        }
    }
    
    private func transitionToMainScreen(viewModel: MainViewModel) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController else {
            return
        }
        mainViewController.viewModel = viewModel
        let navigationController = UINavigationController(rootViewController: mainViewController)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: false, completion: nil)
    }
    
    // MARK: - Animation Funcs
//    private func starSuccessAnimation() {
//        animationView = .init(name: "SuccessAnimation")
//        if let animationView {
//            let screenWidth = view.bounds.width
//            let screenHeight = view.bounds.height
//            let imageCenterX = screenWidth / 2
//            let imageCenterY = screenHeight / 2
//            let animationFrame = CGRect(x: imageCenterX - animationWidth / 2, y: imageCenterY - animationHeight / 2, width: animationWidth, height: animationHeight)
//            animationView.frame = animationFrame
//            animationView.frame = animationFrame
//            animationView.contentMode = .scaleToFill
//            animationView.animationSpeed = 1.5
//            view.addSubview(animationView)
//            animationView.play()
//        }
//    }
    
}
