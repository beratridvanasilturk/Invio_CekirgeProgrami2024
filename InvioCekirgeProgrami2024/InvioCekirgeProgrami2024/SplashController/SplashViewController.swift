//
//  SplashViewController.swift
//  InvioCekirgeProgrami2024
//
//  Created by Berat Ridvan Asilturk on 19.04.2024.
//

import UIKit
import Lottie

//TODO: - Landscape Modu Icin Ekran Constraints Check Edilecek

final class SplashViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var invioImageView: UIImageView!
    // MARK: - Props
    private var badInternetConnection = false
    private let viewModel = MainViewModel()
    private var animationView: LottieAnimationView?
    private let animationWidth: CGFloat = 200
    private let animationHeight: CGFloat = 200
    
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
                self.startFailAnimation()
                self.badInternetConnection = true
                self.viewModel.showAlertForNoInternetConnection(in: self)
            } else {
                self.starSuccessAnimation()
                self.badInternetConnection = false
            }
        }
    }
    
    // MARK: - Animation Funcs
    private func starSuccessAnimation() {
        animationView = .init(name: "SuccessAnimation")
        if let animationView {
            let imageCenterX = invioImageView.center.x
            let imageCenterY = invioImageView.center.y - 95
            let animationFrame = CGRect(x: imageCenterX - animationWidth / 2, y: imageCenterY - animationHeight / 2, width: animationWidth, height: animationHeight)
            animationView.frame = animationFrame
            animationView.contentMode = .scaleToFill
            animationView.animationSpeed = 1.5
            view.addSubview(animationView)
            animationView.play()
        }
    }
    
    private func startFailAnimation() {
        animationView = .init(name: "FailAnimation")
        if let animationView {
            let imageCenterX = invioImageView.center.x
            let imageCenterY = invioImageView.center.y - 95
            let animationFrame = CGRect(x: imageCenterX - animationWidth / 2, y: imageCenterY - animationHeight / 2, width: animationWidth, height: animationHeight)
            animationView.frame = animationFrame
            animationView.contentMode = .scaleToFill
            animationView.animationSpeed = 0.4
            animationView.loopMode = .loop
            view.addSubview(animationView)
            animationView.play()
        }
    }
}
