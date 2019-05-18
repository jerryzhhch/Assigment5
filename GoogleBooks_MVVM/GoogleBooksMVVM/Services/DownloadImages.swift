//
//  DownloadImages.swift
//  DayEight-GoogleBooksSearch
//
//  Created by Jerry Zhou on 5/10/19.
//  Copyright © 2019 Jerry Zhou. All rights reserved.
//

import Foundation
import UIKit

let DLservice = DownloadService.shared

final class DownloadService {
    
    static let shared = DownloadService()
    private init() {}
    
    private let defaultImage = UIImage(named: "defaultImage")!
    
    // use cache to store images downloaded from Internet
    let cache = NSCache<NSString, UIImage>()
    
    func downloadImage(imageUrlString: String, completion: @escaping (UIImage) -> ()) {
        
        // get image if this imgae is already in cache
        if let cachedImage = cache.object(forKey: imageUrlString as NSString) {
            completion(cachedImage)
            return
        }
        
        // cache the image first
        if imageUrlString == "defaultImage" {
            completion(self.defaultImage)
            return
        } else {
            // to cache: 1. construct URL from String
            guard let imageUrl = URL(string: imageUrlString) else {
                completion(self.defaultImage)
                return
            }
            
            // WRONG HERE
            // 2. create a API request
            URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
                if let myError = error {
                    print("Couldn't Retrieve Data: ", myError.localizedDescription)
                    completion(self.defaultImage)
                    return
                }
                
                // then save the image in cache
                if let myData = data {
                    guard let myImage = UIImage(data: myData) else {
                        completion(self.defaultImage)
                        return
                    }
                    
                    self.cache.setObject(myImage, forKey: imageUrlString as NSString)
                    
                    // go to Main Thread to pass the completion
                    DispatchQueue.main.async {
                        completion(myImage)
                    }
                }
                }.resume()
        } // end if-else for imageUrlString
       
    } // end downloadImage function
} // end class
