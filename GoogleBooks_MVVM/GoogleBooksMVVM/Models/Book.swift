//
//  File.swift
//  DayEight-GoogleBooksSearch
//
//  Created by Jerry Zhou on 5/10/19.
//  Copyright © 2019 Jerry Zhou. All rights reserved.
//

import Foundation
import CoreData

class Book {
    
    let id : String
    let title : String
    let subtitle : String
    let authors : [String]
    let publisher : String
    let description : String
    let imageUrl : String
    let previewLink : String
    
    init?(json: [String:Any]) {
        // get id
        let id = json["id"] as! String // String
        
        // get volumeInfo dictionary
        let infoDict = json["volumeInfo"] as! [String:Any] // [String:Any]
        
        // get title
        let title = infoDict["title"] as! String
        
        // get subtitle, if there is a "subtitle" key
        let subTitleExist = infoDict["subtitle"] != nil
        let subtitle : String
        if subTitleExist {
            subtitle = infoDict["subtitle"] as! String
        }
        else {
            subtitle = ""
        }
        
        // get authors, if there is a "authors" key
        let authorsExist = infoDict["authors"] != nil
        var authors = [String]()
        if authorsExist {
            if let authorDict = infoDict["authors"] as? [String] {
                for author in authorDict {
                    authors.append(author)
                }
            }
            else {
                authors.append("Unkown")
            }
            
        }
        else {
            authors.append("Unkown")
        }
        
        // get publisher, if there is a "publisher" key
        let publisherExist = infoDict["publisher"] != nil
        let publisher : String
        if publisherExist {
            publisher = infoDict["publisher"] as! String
        }
        else {
            publisher = "Unkown"
        }
        
        // get description, if there is a "description" key
        let descriptionExist = infoDict["description"] != nil
        let description : String
        if descriptionExist {
            description = infoDict["description"] as! String
        }
        else {
            description = "Description is not aviable at this moment"
        }
        
        // get imageUrl, if there is a "imageLinks" key and a "thumbnail" sub-key
        let imageLinksExist = infoDict["imageLinks"] != nil
        var imageUrl : String
        if imageLinksExist {
            if let imageDict = infoDict["imageLinks"] as? [String:String] {
                let thumbnailExist = imageDict["thumbnail"] != nil
                if thumbnailExist {
                    imageUrl = imageDict["thumbnail"] as! String
                }
                else {
                    imageUrl = "defaultImage"
                }
            } else {
                imageUrl = "defaultImage"
            }
        }
        else {
            imageUrl = "defaultImage"
        }
        
        // get description, if there is a "previewLink" key
        let previewLinkExist = infoDict["previewLink"] != nil
        let previewLink : String
        if previewLinkExist {
            previewLink = infoDict["previewLink"] as! String
        }
        else {
            previewLink = ""
        }
        
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.authors = authors
        self.publisher = publisher
        self.description = description
        self.imageUrl = imageUrl
        self.previewLink = previewLink
    }
    
    init?(entity: NSManagedObject) {
        
        let id = entity.value(forKey: "id") as! String
        let title = entity.value(forKey: "title") as! String
        let subtitle = entity.value(forKey: "subtitle") as! String
        let authors = entity.value(forKey: "authors") as! [String]
        let publisher = entity.value(forKey: "publisher") as! String
        let description = entity.value(forKey: "description") as! String
        let imageUrl = entity.value(forKey: "imageUrl") as! String
        let previewLink = entity.value(forKey: "previewLink") as! String
        
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.authors = authors
        self.publisher = publisher
        self.description = description
        self.imageUrl = imageUrl
        self.previewLink = previewLink
    }
    
    init(_ core: BookData) {
        self.id = core.id!
        self.title = core.title!
        self.subtitle = core.subtitle!
        self.authors = core.authors as! [String]
        self.publisher = core.publisher!
        self.description = core.dsp!
        self.imageUrl = core.imageUrl!
        self.previewLink = core.previewLink!
    }
}
