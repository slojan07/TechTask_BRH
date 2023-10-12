//
//  CommentsViewModelTests.swift
//  TechTask_BRHTests
//
//  Created by wiljan S on 9/25/23.
//

import XCTest
import Combine
@testable import TechTask_BRH

class CommentsViewModelTests: XCTestCase {
    
    var viewModel: CommentsViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = CommentsViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }


    let validJSONData = """
        [{"id": 1, "postId": 1, "name": "This is the Title of the post.","email": "This is the email of the post","body": "This is the body of the post."}]
        """.data(using: .utf8)
    
    
    enum TestError: Error {
        case mockError
    }

    class MockURLSession: URLSessionProtocol {
        var data: Data?
        var response: URLResponse?
        var error: Error?

        init(data: Data?, response: URLResponse?, error: Error?) {
            self.data = data
            self.response = response
            self.error = error
        }

        func dataTask(
            with url: URL,
            completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
        ) -> URLSessionDataTask {
            return MockURLSessionDataTask(data: data, response: response, error: error, completionHandler: completionHandler)
        }
    }


    class MockURLSessionDataTask: URLSessionDataTask {
        private let data: Data?
        private let respons: URLResponse?
        private let erro: Error?
        private let completionHandler: (Data?, URLResponse?, Error?) -> Void

        init(data: Data?, response: URLResponse?, error: Error?, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
            self.data = data
            self.respons = response
            self.erro = error
            self.completionHandler = completionHandler
        }

        override func resume() {
            completionHandler(data, response, error)
        }
    }

    func testfetchCommentsSuccess() {
        
        let mockResponse = HTTPURLResponse(url: URL(string: "https://jsonplaceholder.typicode.com/posts/1/comments/")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let mockSession = MockURLSession(data: validJSONData, response: mockResponse, error: nil)
        viewModel.session = mockSession

        let expectation = self.expectation(description: "Successful API Call")

        viewModel.fetchComments(for: 1)

        DispatchQueue.main.async {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5.0) { error in
            XCTAssertNil(self.viewModel.error)
            XCTAssertEqual(self.viewModel.comments.count, 1)
        }
    }


    func testfetchCommentFailure() {
        
        let mockResponse = HTTPURLResponse(url: URL(string: "https://jsonplaceholder.typicode.com/posts/1/comments/")!, statusCode: 404, httpVersion: nil, headerFields: nil)
        
        let mockSession = MockURLSession(data: nil, response: mockResponse, error: TestError.mockError)
        viewModel.session = mockSession

        let expectation = self.expectation(description: "API Call Failed")

        viewModel.fetchComments(for: 1)

        DispatchQueue.main.async {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5.0) { error in
            XCTAssertNil(self.viewModel.error)
            XCTAssertEqual(self.viewModel.comments.count, 0)
        }
    }


}



