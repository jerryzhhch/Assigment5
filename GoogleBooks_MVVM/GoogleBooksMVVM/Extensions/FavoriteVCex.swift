//
//  FavoriteVC.swift
//  DayEight-GoogleBooksSearch
//
//  Created by Jerry Zhou on 5/11/19.
//  Copyright © 2019 Jerry Zhou. All rights reserved.
//

import Foundation
import UIKit

extension FavoriteViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            let book = favoriteViewModel.books[indexPath.row]
            favoriteViewModel.books.remove(at: indexPath.row)
            coreDataService.deleteByCoreData(book)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = storyboard?.instantiateViewController(withIdentifier: DetailViewController.identifier) as! DetailViewController

        let corebook = favoriteViewModel.books[indexPath.row]
        detailVC.book = Book(corebook)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

extension FavoriteViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteViewModel.books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteViewCell", for: indexPath) as! FavoriteViewCell
        
        let corebook = favoriteViewModel.books[indexPath.row]
        let book = Book(corebook)
        cell.configiure(book: book)
        
        return cell
    }
    
}

// For MVVM
extension FavoriteViewController : FavoriteViewModelDelegate {
    func updateView() {
        DispatchQueue.main.async {
            self.favoriteView.reloadData()
        }
    }
}
