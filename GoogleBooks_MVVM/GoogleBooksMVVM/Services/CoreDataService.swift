//
//  CoreDataService.swift
//  DayEight-GoogleBooksSearch
//
//  Created by Jerry Zhou on 5/11/19.
//  Copyright © 2019 Jerry Zhou. All rights reserved.
//

import Foundation
import CoreData
import UIKit

let coreDataService = CoreDataService.shared


final class CoreDataService {
    
    static let shared = CoreDataService()
    private init() {}
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var context : NSManagedObjectContext {
        return appDelegate.persistentContainer.viewContext
    }
    
    // SAVE
    func saveBook(_ book: Book){
        print("saving...")
        
        // create an entity description
        let entity = NSEntityDescription.entity(forEntityName: "BookData", in: context)
        
        // initialize the record
        let record = NSManagedObject(entity: entity!, insertInto: context)
      
        record.setValue(book.id, forKey: "id")
        record.setValue(book.title, forKey: "title")
        record.setValue(book.subtitle, forKey: "subtitle")
        record.setValue(book.authors, forKey: "authors")
        record.setValue(book.publisher, forKey: "publisher")
        record.setValue(book.description, forKey: "dsp")
        record.setValue(book.imageUrl, forKey: "imageUrl")
        
        // save changes on Context
        saveContext("<\(book.title)> was saved.")
    }
    
    // GET
    func getBook() -> [BookData] {
        var books = [BookData]()
        // set a NSFetchRequest
        let fetchRequest = NSFetchRequest<BookData>(entityName: "BookData")
        do {
            let data = try context.fetch(fetchRequest)
            books = data
        } catch {
            print("Failed To Fectch Data: \(error.localizedDescription)")
            books = []
        }
        return books
    }
    
    // DELETE
    func deleteByCoreData(_ book: BookData) {
        context.delete(book)
        saveContext("<\(book.title!)> was deleted.")
    }
    
    func deleteByClass(_ book: Book) {
        // set a NSFetchRequest
        let fetchRequest = NSFetchRequest<BookData>(entityName: "BookData")
        fetchRequest.predicate = NSPredicate(format: "id = %@", book.id)
        do {
            let data = try context.fetch(fetchRequest)
            let dataToDelete = data[0] as NSManagedObject
            context.delete(dataToDelete)
            saveContext("<\(book.title)> was deleted.")
        } catch {
            print("Failed To Fectch Data: \(error.localizedDescription)")
        }
    }
    
    // helping function
    func saveContext(_ message: String) {
        do {
            try context.save()
            print(message)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func isExist(_ book: Book, _ action: String, completion: @escaping (String) -> Void) {
        switch action{
        case "setup":
            if checkExistence(book) {
                completion("Remove")
            } else {
                completion("Save")
            }
        case "buttonTapped":
            if checkExistence(book) {
                deleteByClass(book)
                completion("Save")
            } else {
                saveBook(book)
                completion("Remove")
            }
        default:
            break
        }
    }
    
    func checkExistence(_ book: Book) -> Bool {
        // set a NSFetchRequest
        let fetchRequest = NSFetchRequest<BookData>(entityName: "BookData")
        fetchRequest.predicate = NSPredicate(format: "id = %@", book.id)
        
        do {
            let books = try appDelegate.persistentContainer.viewContext.fetch(fetchRequest)
            print("number of this book in list: ", books.count)
            
            // if this book exists in CoreData (unlike it), unlike it and remove from CoreData
            if books.count > 0 {
                return true
            } else {
                return false
            }
        } catch {
            print("Error: \(error.localizedDescription)")
            return false
        }
    }
    
} // end class
