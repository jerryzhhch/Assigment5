//
//  DayEight_GoogleBooksSearchTests.swift
//  DayEight-GoogleBooksSearchTests
//
//  Created by Jerry Zhou on 5/10/19.
//  Copyright © 2019 Jerry Zhou. All rights reserved.
//

import XCTest
@testable import GoogleBooksMVVM

class GoogleBooksMVVMTests: XCTestCase {

    var apiService: CoreDataService!
    var dlService: DownloadService!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        apiService = CoreDataService.shared
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
//    func testOne() {
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        // AAA - Assemble, Activate, Assert
//        let url = ""
//        let vc = SearchViewController()
//        vc.search(url)
//        XCTAssertTrue(vc.books.isEmpty)
//    }

//    func testTwo() {
//        var books = [Book]()
//
//        self.measure {
//            let bks = apiService.getBook()
//            books = bks
//        }
//
//        XCTAssertTrue(!books.isEmpty)
//    }
    
//    func testThree() {
//        let book = Book(id: "test ID", title: "test title")
//        let before = apiService.getBook()
//
//        self.measureMetrics([XCTPerformanceMetric.wallClockTime], automaticallyStartMeasuring: false) {
//            startMeasuring()
//            apiService.saveBook(book)
//            stopMeasuring()
//        }
//        let after = apiService.getBook()
//
//        XCTAssertEqual(before.count, after.count)
//    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
