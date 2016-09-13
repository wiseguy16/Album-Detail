//
//  AlbumsTests.swift
//  AlbumsTests
//
//  Created by Gregory Weiss on 9/13/16.
//  Copyright © 2016 The Iron Yard. All rights reserved.
//

import XCTest
@testable import Albums


class AlbumsTests: XCTestCase
{
    
    var viewController: AlbumsTableViewController!
    
    override func setUp()
    {
        super.setUp()
        viewController = AlbumsTableViewController()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
   
    
    override func tearDown()
    {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
     func testFetchingAlbumDataAndLoadingTable()
     {
        //given
        let mockDataProvider = MockDataProvider()
        viewController.dataProvider = mockDataProvider
        
        //when
        XCTAssertNil(mockDataProvider.tableView, "Before loading the tableview should be nil")
      
        // This will cause the datasource methods to be run since we are accessing the view
         let _ = viewController.view
        
        //then
        XCTAssertTrue(mockDataProvider.tableView != nil, "the tableview should be set")
        XCTAssert(mockDataProvider.tableView == viewController.tableView, "the tableview should be set to the tableview of the datasource")
     }
    
    /*
    func testExample()
    {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample()
    {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
 */
    
}


class MockDataProvider: NSObject, AlbumDataProviderProtocol
{
    weak var tableView: UITableView!
    var albums = [Album]()
    var api: APIController!
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        return UITableViewCell()
    }
    
    func didReceiveAPIResults(_ results: [Any])
    {
        DispatchQueue.main.async {
            self.albums = Album.albumsWithJSON(results)
            self.tableView.reloadData()
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
}






