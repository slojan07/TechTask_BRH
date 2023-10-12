//
//  PostsViewModelTests.swift
//  TechTask_BRHTests
//
//  Created by wiljan S on 9/24/23.
//

import XCTest
import Combine
@testable import TechTask_BRH

class PostsViewModelTests: XCTestCase {
    
    var viewModel: PostsViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = PostsViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    let validJSONData = """
        [{"userId": 1, "id": 1, "title": "Test Title", "body": "Test Body"}]
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

    func testFetchPostsSuccess() {
        
        let mockResponse = HTTPURLResponse(url: URL(string: "https://jsonplaceholder.typicode.com/posts")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let mockSession = MockURLSession(data: validJSONData, response: mockResponse, error: nil)
        viewModel.session = mockSession

        let expectation = self.expectation(description: "Successful API Call")

        viewModel.fetchPosts()

        DispatchQueue.main.async {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5.0) { error in
            XCTAssertNil(self.viewModel.error)
            XCTAssertEqual(self.viewModel.posts.count, 1)
        }
    }


    func testFetchPostsFailure() {
        
        let mockResponse = HTTPURLResponse(url: URL(string: "https://jsonplaceholder.typicode.com/posts")!, statusCode: 404, httpVersion: nil, headerFields: nil)
        let mockSession = MockURLSession(data: nil, response: mockResponse, error: TestError.mockError)
        viewModel.session = mockSession

        let expectation = self.expectation(description: "API Call Failed")

        viewModel.fetchPosts()

        DispatchQueue.main.async {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5.0) { error in
            XCTAssertNil(self.viewModel.error)
            XCTAssertEqual(self.viewModel.posts.count, 0)
        }
    }


}
