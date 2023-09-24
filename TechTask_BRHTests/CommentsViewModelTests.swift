//
//  CommentsViewModelTests.swift
//  TechTask_BRHTests
//
//  Created by wiljan S on 9/25/23.
//
import XCTest
import Combine
@testable import TechTask_BRH

final class CommentsViewModelTests: XCTestCase {
    var viewModel: CommentsViewModel!
    var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        viewModel = CommentsViewModel()
    }

    override func tearDown() {
        viewModel = nil
        cancellables.removeAll()
        super.tearDown()
    }

    func testFetchComments() {
       
        let expectation = XCTestExpectation(description: "Fetch Comments")
        viewModel.fetchComments(for: 1)
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            XCTAssertFalse(self.viewModel.comments.isEmpty)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
    }
}
