//
//  SearchViewController.swift
//  DayEight-GoogleBooksSearch
//
//  Created by Jerry Zhou on 5/10/19.
//  Copyright © 2019 Jerry Zhou. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var searchBar: UISearchBar!

    let searchController = UISearchController(searchResultsController: nil)
    
    // For MVVM
    var searchViewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSearchBar()
    }
    
    // helping functions
    func setupView() {
        
        // register cell
        tableView.register(UINib(nibName: "TableViewCell", bundle: .main), forCellReuseIdentifier: TableViewCell.identifier)
        
        // auto layout
        tableView.estimatedRowHeight = 80
        tableView.tableFooterView = UIView(frame: .zero)
        definesPresentationContext = true
        searchViewModel.delegate = self
    }
    
    
    func setupSearchBar() {
        searchController.definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search books..."
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

