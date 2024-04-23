//
//  FavoriteListViewController.swift
//  InvioCekirgeProgrami2024
//
//  Created by Berat Ridvan Asilturk on 18.04.2024.
//

import UIKit
import Lottie

final class FavoriteListViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak private var tableView: UITableView!
    private let viewModel = FavoriteListViewModel()
    private var animationView: LottieAnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: ExpandableCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: ExpandableCell.cellIdentifier)
        tableView.reloadData()
        title = "Favoriler"
        
        checkFavListEmpty()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        PersistentManager.shared.delegate = self
    }
    
    // Landscape - Portrait Mode Controll
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { _ in
            // Ekran boyutları güncellendiğinde main.bonds'u yeniden atamada kullanildi
            self.animationView?.removeFromSuperview()
            self.checkFavListEmpty()
        }, completion: nil)
    }
    
    private func checkFavListEmpty() {
        if viewModel.favList.isEmpty {
            startEmptyListAnimation()
            let label = UILabel()
            label.text = "Henüz bir üniversite eklemedin!"
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 20)
            label.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(label)
            
            NSLayoutConstraint.activate([
                label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        }
    }
    
    // MARK: - Animation Funcs
    private func startEmptyListAnimation() {
        let animationWidth: CGFloat = 180
        let animationHeight: CGFloat = 250
        animationView = .init(name: "invioCustomAnimation")
        if let animationView {
            let screenWidth = view.bounds.width
            let screenHeight = view.bounds.height
            let imageCenterX = screenWidth / 2
            let imageCenterY = screenHeight / 2
            let animationFrame = CGRect(x: imageCenterX - animationWidth / 2, y: imageCenterY - animationHeight / 2 - 50, width: animationWidth, height: animationHeight)
            animationView.frame = animationFrame
            animationView.loopMode = .loop
            animationView.contentMode = .scaleToFill
            animationView.animationSpeed = 0.7
            view.addSubview(animationView)
            animationView.play()
        }
    }
}

//MARK: - Table View Delegate & Data Source
extension FavoriteListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.favList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExpandableCell.cellIdentifier, for: indexPath) as! ExpandableCell
        let model = viewModel.favList[indexPath.row]
        cell.model = model
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        viewModel.favList[indexPath.row].hideContent = !viewModel.favList[indexPath.row].hideContent
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}

//MARK: - PersistentManagerDelegate
extension FavoriteListViewController: PersistentManagerDelegate {
    func favListUpdated() {
        viewModel.updateModel()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        checkFavListEmpty()
    }
}
