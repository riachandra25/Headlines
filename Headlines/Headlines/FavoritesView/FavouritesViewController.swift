//
//  FavouritesViewController.swift
//  Headlines
//
//  Created by Ria Chandra.
//  Copyright © 2023 Example. All rights reserved.
//

import UIKit

final class FavouritesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private let viewModel: FavoritesViewModel
    
    init(viewModel: FavoritesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        reload()
    }
}

private extension FavouritesViewController {
    // configure UI
    func configureView() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
        navigationItem.rightBarButtonItem?.tintColor = .systemYellow
        tableView.register(UINib(nibName: "FavoritesTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    @objc func doneButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    // reload table with favorite article list
    func reload() {
        tableView.reloadData()
        let favouriteStr = viewModel.totalFavoriteCount > 1 ? NSLocalizedString("favourites", comment: "") : NSLocalizedString("favourite", comment: "")
        self.navigationItem.title = String(
            format: NSLocalizedString(
                "%d %@", comment: ""
            ),
            viewModel.totalFavoriteCount,
            favouriteStr
        )
    }
}

extension FavouritesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterArticles(with: searchText)
        reload()
    }
}

// MARK: - UITableViewDataSource
extension FavouritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.totalFavoriteCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? FavoritesTableViewCell else {
            fatalError(
                "Failed to dequeue a cell with identifier"
            )
        }
        
        if let article = viewModel.article(at: indexPath.row) {
            cell.article = article // set article data to tableview cell
        }
        return cell
    }
}
