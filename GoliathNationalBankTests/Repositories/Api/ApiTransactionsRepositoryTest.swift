//
//  ApiTransactionsRepositoryTest.swift
//  GoliathNationalBankTests
//
//  Created by Gastón Sobrevilla on 11/08/2019.
//  Copyright © 2019 Goliath National Bank. All rights reserved.
//

import XCTest
@testable import GoliathNationalBank
import OHHTTPStubs

class ApiTransactionsRepositoryTest: XCTestCase {
    
    lazy var repository = ApiTransactionsRepository()

    override func setUp() {
        stub(condition: isPath("/transactions")) { (request) -> OHHTTPStubsResponse in
            return OHHTTPStubsResponse(
                fileAtPath: OHPathForFile("transactions.json", type(of: self))!,
                statusCode: 200,
                headers: ["Content-Type":"application/json"]
            )
        }
    }

    override func tearDown() {
        OHHTTPStubs.removeAllStubs()
    }

    func testGetTransactionsList() {
        let expectation = XCTestExpectation(description: "Returns the transactions")
        repository.getTransactionsList { (success, transactions, error) in
            XCTAssertTrue(success)
            XCTAssertNil(error)
            XCTAssertEqual(transactions?.count, 3)
            XCTAssertEqual(transactions?.map({ $0.sku }), ["SKU1", "SKU2", "SKU3"])
            XCTAssertEqual(transactions?.map({ $0.amount?.stringValue }), ["16.3", "31.7", "18.4"])
            XCTAssertEqual(transactions?.map({ $0.currency }), ["AUD", "USD", "EUR"])
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}
