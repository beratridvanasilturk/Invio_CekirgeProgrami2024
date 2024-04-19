//
//  FavListViewController.swift
//  InvioCekirgeProgrami2024
//
//  Created by Berat Ridvan Asilturk on 18.04.2024.
//

// TODO: - Need Fix UI Update Delegate Issue When Tapped UnFav

import UIKit

final class FavListViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    private let viewModel = FavListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: ExpandableCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: ExpandableCell.cellIdentifier)
        tableView.reloadData()
        
        checkFavListEmpty()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        PersistentManager.shared.delegate = self
    }
    
    private func checkFavListEmpty() {
        if viewModel.favList.isEmpty {
            let label = UILabel()
            label.text = "Henüz bir üniversite eklemedin!"
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 24)
            
            // Auto Layout'u kullanarak ekranın ortasına yerleştirme
            label.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(label)
            
            NSLayoutConstraint.activate([
                label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
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
    }
}
