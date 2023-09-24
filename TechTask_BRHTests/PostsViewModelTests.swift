//
//  PostsViewModelTests.swift
//  TechTask_BRHTests
//
//  Created by wiljan S on 9/24/23.
//

import XCTest
import Combine
@testable import TechTask_BRH

final class PostsViewModelTests: XCTestCase {
    
    var viewModel: PostsViewModel!

    override func setUp() {
        super.setUp()
        viewModel = PostsViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testFetchPosts() {
        
        let expectation = XCTestExpectation(description: "Fetch Posts")

       
        viewModel.fetchPosts()

       
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
           
            XCTAssertFalse(self.viewModel.posts.isEmpty)
            expectation.fulfill()
        }

       
        wait(for: [expectation], timeout: 2.0)
    }
}
