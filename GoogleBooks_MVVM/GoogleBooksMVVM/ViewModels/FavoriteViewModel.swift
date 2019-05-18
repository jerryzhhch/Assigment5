//
//  FavoriteViewModel.swift
//  DayEight-GoogleBooksSearch
//
//  Created by Jerry Zhou on 5/17/19.
//  Copyright © 2019 Jerry Zhou. All rights reserved.
//

import Foundation

protocol FavoriteViewModelDelegate : class {
    func updateView()
}

class FavoriteViewModel {
    
    weak var delegate: FavoriteViewModelDelegate?
    
    var books = [BookData]() {
        didSet{
            delegate?.updateView()
        }
    }
    
    func get() {
        books = coreDataService.getBook()
        print("Liked book count: \(books.count)")
    }
    
}
