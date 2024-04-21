//
//  FavListViewController.swift
//  InvioCekirgeProgrami2024
//
//  Created by Berat Ridvan Asilturk on 18.04.2024.
//

// TODO: - Need Fix UI Update Delegate Issue When Tapped UnFav

import UIKit
import Lottie

final class FavListViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    private let viewModel = FavListViewModel()
    
    private var animationView: LottieAnimationView?
    private let animationWidth: CGFloat = 180
    private let animationHeight: CGFloat = 180
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: ExpandableCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: ExpandableCell.cellIdentifier)
        tableView.reloadData()
        
        checkFavListEmpty()
        
        title = "Favoriler"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        PersistentManager.shared.delegate = self
    }
    
    private func checkFavListEmpty() {
        if viewModel.favList.isEmpty {
            emptyAnimation()
            let label = UILabel()
            label.text = "Henüz bir üniversite eklemedin!"
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 20)
            
            // Auto Layout'u kullanarak ekranın ortasına yerleştirme
            label.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(label)
            
            NSLayoutConstraint.activate([
                label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        }
    }
    
    // MARK: - Animation Funcs
    private func emptyAnimation() {
        animationView = .init(name: "emptyAnimation2")
        if let animationView {
            let screenWidth = view.bounds.width
            let screenHeight = view.bounds.height
            let imageCenterX = screenWidth / 2
            let imageCenterY = screenHeight / 2
            let animationFrame = CGRect(x: imageCenterX - animationWidth / 2, y: imageCenterY - animationHeight / 2 - 100, width: animationWidth, height: animationHeight)
            animationView.frame = animationFrame
            animationView.frame = animationFrame
            animationView.contentMode = .scaleToFill
            animationView.loopMode = .loop
            animationView.animationSpeed = 1
            view.addSubview(animationView)
            animationView.play()
        }
    }
}

//MARK: - Table View Delegate & Data Source
extension FavListViewController: UITableViewDelegate, UITableViewDataSource {
    
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
extension FavListViewController: PersistentManagerDelegate {
    func favListUpdated() {
        viewModel.updateModel()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        checkFavListEmpty()
    }
}
