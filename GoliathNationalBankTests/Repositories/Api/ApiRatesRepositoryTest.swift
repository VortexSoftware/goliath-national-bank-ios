//
//  ApiRatesRepositoryTest.swift
//  GoliathNationalBankTests
//
//  Created by Gastón Sobrevilla on 11/08/2019.
//  Copyright © 2019 Goliath National Bank. All rights reserved.
//

import XCTest
@testable import GoliathNationalBank
import OHHTTPStubs

class ApiRatesRepositoryTest: XCTestCase {
    
    lazy var repository = ApiRatesRepository()
    
    override func setUp() {
        stub(condition: isPath("/rates")) { (request) -> OHHTTPStubsResponse in
            return OHHTTPStubsResponse(
                fileAtPath: OHPathForFile("rates.json", type(of: self))!,
                statusCode: 200,
                headers: ["Content-Type":"application/json"]
            )
        }
    }
    
    override func tearDown() {
        OHHTTPStubs.removeAllStubs()
    }
    
    func testGetTransactionsList() {
        let expectation = XCTestExpectation(description: "Returns the rates")
        repository.getRatesList { (success, rates, error) in
            XCTAssertTrue(success)
            XCTAssertNil(error)
            XCTAssertEqual(rates?.count, 3)
            XCTAssertEqual(rates?.map({ $0.to }), ["EUR", "USD", "AUD"])
            XCTAssertEqual(rates?.map({ $0.rate?.stringValue }), ["0.84", "1.19", "0.58"])
            XCTAssertEqual(rates?.map({ $0.from }), ["USD", "EUR", "USD"])
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}

