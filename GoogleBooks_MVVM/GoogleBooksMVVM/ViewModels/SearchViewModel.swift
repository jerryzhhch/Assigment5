//
//  SearchViewModel.swift
//  DayEight-GoogleBooksSearch
//
//  Created by Jerry Zhou on 5/17/19.
//  Copyright © 2019 Jerry Zhou. All rights reserved.
//

import Foundation

protocol SearchViewModelDelegate : class {
    func updateViwe()
}

class SearchViewModel {
    
    weak var delegate: SearchViewModelDelegate?
    
    var books = [Book]() {
        didSet {
            // update table view by using delegation
            delegate?.updateViwe()
        }
        willSet {
            
        }
    }
    
    func get(_ query: String) {
        
        bookService.search(query) {
            [unowned self] (bk) in
            guard let bookArray = bk else {
                return
            }
            self.books = bookArray
            print("Book count: \(self.books.count)")
        }
    }
    
} // end class
