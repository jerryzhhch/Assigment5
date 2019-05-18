//
//  DetailViewController.swift
//  DayEight-GoogleBooksSearch
//
//  Created by Jerry Zhou on 5/10/19.
//  Copyright © 2019 Jerry Zhou. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var authorsLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var detailText: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    
    static let identifier = "DetailViewController"
    
    // dependency injection
    var book : Book!
       
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
  
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        // save book to CoreData
        coreDataService.isExist(self.book, "buttonTapped") { label in
            self.saveButton.setTitle(label, for: .normal)
            if label == "Save" {
                self.likeLabel.isHidden = true
            }
            if label == "Remove" {
                self.likeLabel.isHidden = false
            }
        }
    }
    
    
    // helping functions
    func setupView() {
        saveButton.layer.cornerRadius = saveButton.layer.frame.size.height / 2

//        likeLabel.isHidden = false
        
        guard let myBook = book else {
            return
        }

        let id = myBook.id
        let title = myBook.title
        let subtitle = myBook.subtitle
        let authors = myBook.authors.joined(separator: ", ")
        let publisher = myBook.publisher
        let description = myBook.description


        let url = myBook.imageUrl
        if url == "defaultImage" {
            DispatchQueue.main.async {
                self.bookImage.image = UIImage(named: "defaultImage")
            }
        } else {
            DLservice.downloadImage(imageUrlString: url) { (myImage) in
                DispatchQueue.main.async {
                    self.bookImage.image = myImage
                }
            }
        }

        self.idLabel.text = "ID: " + id
        if subtitle == "" {
            self.titleLabel.text = title
        } else {
            self.titleLabel.text = title + ": " + subtitle
        }
        self.authorsLabel.text = "Authors: " + authors
        self.publisherLabel.text = "Publisher: " + publisher
        self.detailText.text = description
        
        DispatchQueue.main.async {
            coreDataService.isExist(self.book, "setup") { label in                self.saveButton.setTitle(label, for: .normal)
                if label == "Save" {
                    self.likeLabel.isHidden = true
                }
                if label == "Remove" {
                    self.likeLabel.isHidden = false
                }
            }
        }
        
    }

}
