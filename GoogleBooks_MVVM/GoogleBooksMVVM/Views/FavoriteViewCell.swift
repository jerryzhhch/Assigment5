//
//  DetailViewCell.swift
//  DayEight-GoogleBooksSearch
//
//  Created by Jerry Zhou on 5/11/19.
//  Copyright © 2019 Jerry Zhou. All rights reserved.
//

import UIKit

class FavoriteViewCell: UITableViewCell {

    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var byLabel: UILabel!
    @IBOutlet weak var authorsLabel: UILabel!
    
    static let identifier = "DetailViewCell"
    
    func configiure(book: Book) {
        self.titleLabel.text = book.title
        self.byLabel.text = "By"
        self.authorsLabel.text = book.authors.joined(separator: ", ")

        if book.imageUrl == "defaultImage" {
            self.detailImage.image = UIImage(named: "defaultImage")
        } else {
            DLservice.downloadImage(imageUrlString: book.imageUrl) { (myImage) in
                DispatchQueue.main.async {
                    self.detailImage.image = myImage
                }
            }
        }
       
    } //end function
    
} // end class
