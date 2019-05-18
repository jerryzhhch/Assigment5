//
//  TableViewCell.swift
//  DayEight-GoogleBooksSearch
//
//  Created by Jerry Zhou on 5/10/19.
//  Copyright © 2019 Jerry Zhou. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var byLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    static let identifier = "tableCell"
    
    func configure(book: Book) {
        titleLabel.text = book.title
        byLabel.text = "By"
        authorLabel.text = book.authors.joined(separator: ", ")
        let url = book.imageUrl
        if url == "defaultImage" {
            DispatchQueue.main.async {
                self.bookImage.image = UIImage(named: "defaultImage")
            }
        }
        else {
            DLservice.downloadImage(imageUrlString: url) { image in
                DispatchQueue.main.async {
                    self.bookImage.image = image
                }
            }
        }
    } //end function
    
} // end class
