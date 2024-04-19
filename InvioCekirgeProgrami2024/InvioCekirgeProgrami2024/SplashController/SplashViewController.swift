//
//  SplashViewController.swift
//  InvioCekirgeProgrami2024
//
//  Created by Berat Ridvan Asilturk on 19.04.2024.
//

import UIKit
import Lottie

final class SplashViewController: UIViewController {
    
    private var badInternetConnection = false
    
    private let viewModel = MainViewModel()
    private var animationView: LottieAnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startAnimation()
        checkInternet()
        getData()
      
    }
    
    private func checkInternet() {
        viewModel.checkInternetConnection { isConnected in
            if !isConnected {
                self.animationView!.stop()
                self.badInternetConnection = true
                self.viewModel.showAlertForNoInternetConnection(in: self)
            } else {
                self.badInternetConnection = false
            }
        }
    }
    
    private func startAnimation() {
        animationView = .init(name: "confetti")
        animationView!.frame = view.bounds
        animationView!.contentMode = .scaleAspectFit
        animationView!.loopMode = .loop
        animationView!.animationSpeed = 0.7
        view.addSubview(animationView!)
        animationView!.play()
    }
    
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
}
