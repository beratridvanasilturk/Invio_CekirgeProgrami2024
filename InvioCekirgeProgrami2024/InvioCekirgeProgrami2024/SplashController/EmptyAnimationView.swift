//
//  Empty.swift
//  InvioCekirgeProgrami2024
//
//  Created by Berat Ridvan Asilturk on 21.04.2024.
//

import UIKit
import Lottie

class EmptyAnimationView: UIView {
    private var animationView: LottieAnimationView?
    
    // MARK: - Animation Funcs
    func startFailAnimation() {
        animationView = .init(name: "FailAnimation")
        let screenWidth = bounds.width
        let screenHeight = bounds.height
        let imageCenterX = screenWidth / 2
        let imageCenterY = screenHeight / 2
        let animationWidth: CGFloat = 180 // Animasyonun genişliği
        let animationHeight: CGFloat = 180 // Animasyonun yüksekliği
        let animationFrame = CGRect(x: imageCenterX - animationWidth / 2, y: imageCenterY - animationHeight / 2, width: animationWidth, height: animationHeight)
        if let animationView {
            animationView.frame = animationFrame
            animationView.contentMode = .scaleToFill
            animationView.animationSpeed = 1.5
            addSubview(animationView)
            animationView.play()
        }
    }
    
    func startSuccessAnimation() {
        animationView = .init(name: "FailAnimation")
        let screenWidth = bounds.width
        let screenHeight = bounds.height
        let imageCenterX = screenWidth / 2
        let imageCenterY = screenHeight / 2
        let animationWidth: CGFloat = 180 // Animasyonun genişliği
        let animationHeight: CGFloat = 180 // Animasyonun yüksekliği
        let animationFrame = CGRect(x: imageCenterX - animationWidth / 2, y: imageCenterY - animationHeight / 2, width: animationWidth, height: animationHeight)
        if let animationView {
            animationView.frame = animationFrame
            animationView.contentMode = .scaleToFill
            animationView.animationSpeed = 1.5
            addSubview(animationView)
            animationView.play()
        }
    }
}
