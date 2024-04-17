//
//  FavListViewController.swift
//  InvioCekirgeProgrami2024
//
//  Created by Berat Ridvan Asilturk on 18.04.2024.
//

import UIKit

class FavListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = FavListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: ExpandableCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: ExpandableCell.cellIdentifier)
        tableView.reloadData()

    }
}

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
