//
//  BookService.swift
//  DayEight-GoogleBooksSearch
//
//  Created by Jerry Zhou on 5/17/19.
//  Copyright © 2019 Jerry Zhou. All rights reserved.
//

import Foundation

let bookService = BookService.shared

class BookService {
    
    static let shared = BookService()
    private init() {}
    
    // get books from API
    func search(_ query: String, completion: @escaping ([Book]?) -> ()) {
        // add search query to URL string
        let urlString = "https://www.googleapis.com/books/v1/volumes?q=" + query
        
        // allow URL can deal with the whitespace in the searching book name
        let escapedQuery = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        // convert to URL?, and unwrap (URL? -> URL)
        guard let url = URL(string: escapedQuery!) else {
            print("Error: Invalid URL")
            return
        }
        
        // DON'T forget to *resume*
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let myError = err {
                print("Error: \(myError.localizedDescription)")
            }
            
            // get Data
            if let myData = data {
                
                // create a JSON object (there is a throw)
                do {
                    guard let jsonObject = try JSONSerialization.jsonObject(with: myData, options: []) as? [String:Any], let parseData = jsonObject["items"] as? [[String:Any]] else {
                        print("Bad JSON Format")
                        completion(nil)
                        return
                    }
                    
                    var myBooks = [Book]()
                    for item in parseData {
                        if let book = Book(json: item) {
                            myBooks.append(book)
                        }
                    }
                    completion(myBooks)
                    
                } catch {
                    print("Couldn't Serialize Object: \(error.localizedDescription)")
                    completion(nil)
                }
            }
        }.resume()
    } // end function
    
} // end class
