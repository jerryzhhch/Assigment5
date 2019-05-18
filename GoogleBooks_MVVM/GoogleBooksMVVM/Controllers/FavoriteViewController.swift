//
//  FavoriteViewController.swift
//  DayEight-GoogleBooksSearch
//
//  Created by Jerry Zhou on 5/10/19.
//  Copyright © 2019 Jerry Zhou. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {

    @IBOutlet weak var favoriteView: UITableView!
    
    var favoriteViewModel = FavoriteViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        favoriteViewModel.get()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        favoriteViewModel.get()
    }
    
    // helping functions
    func setupView() {
        favoriteView.rowHeight = 150
        favoriteView.tableFooterView = UIView(frame: .zero)
        favoriteViewModel.delegate = self
        title = "Saved Books"
    }
}
