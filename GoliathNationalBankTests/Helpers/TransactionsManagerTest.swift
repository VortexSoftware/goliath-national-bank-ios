//
//  TransactionsManagerTest.swift
//  GoliathNationalBankTests
//
//  Created by Gastón Sobrevilla on 11/08/2019.
//  Copyright © 2019 Goliath National Bank. All rights reserved.
//

import XCTest
@testable import GoliathNationalBank

class TransactionsManagerTest: XCTestCase {
    
    func testGetProductsWithoutTransactionsWithDifferentSKUs() {
        let manager = TransactionsManager(transactions: transactionsWithDifferentSKUs, rates: rates)
        let products = manager.getProductsWithoutTransactions()
        XCTAssertEqual(products.count, 3)
        XCTAssertEqual(products.map({ $0.sku }), ["SKU1", "SKU2", "SKU3"])
        XCTAssertEqual(products.map({ $0.total }), [nil, nil, nil])
    }
    
    func testGetProductsWithoutTransactionsWithDuplicatedSKUs() {
        let manager = TransactionsManager(transactions: transactionsWithDifferentSKUs, rates: rates)
        let products = manager.getProductsWithoutTransactions()
        XCTAssertEqual(products.count, 3)
        XCTAssertEqual(products.map({ $0.sku }), ["SKU1", "SKU2", "SKU3"])
        XCTAssertEqual(products.map({ $0.total }), [nil, nil, nil])
        XCTAssertEqual(products.map({ $0.total }), [nil, nil, nil])
    }
    
    func testGetProductWithTransactions() {
        let manager = TransactionsManager(transactions: transactionsWithDuplicatedSKUs, rates: rates)
        let product = manager.getProductWithTransactions(for: "SKU1")
        XCTAssertEqual(product.sku, "SKU1")
        XCTAssertEqual(product.total?.stringValue, "189")
        XCTAssertEqual(product.transactions?.count, 2)
        XCTAssertEqual(product.transactions?.first?.amount?.stringValue, "100")
        XCTAssertEqual(product.transactions?.last?.amount?.stringValue, "100")
    }
}

extension TransactionsManagerTest {
    
    var transactionsWithDifferentSKUs: [Transaction] {
        let transaction1 = Transaction(sku: "SKU1", currency: "USD", amount: NSDecimalNumber(string: "100"))
        let transaction2 = Transaction(sku: "SKU2", currency: "EUR", amount: NSDecimalNumber(string: "200"))
        let transaction3 = Transaction(sku: "SKU3", currency: "USD", amount: NSDecimalNumber(string: "300"))
        return [transaction1, transaction2, transaction3]
    }
    
    var transactionsWithDuplicatedSKUs: [Transaction] {
        let transaction1 = Transaction(sku: "SKU1", currency: "USD", amount: NSDecimalNumber(string: "100"))
        let transaction2 = Transaction(sku: "SKU2", currency: "EUR", amount: NSDecimalNumber(string: "200"))
        let transaction3 = Transaction(sku: "SKU3", currency: "USD", amount: NSDecimalNumber(string: "300"))
        let transaction4 = Transaction(sku: "SKU1", currency: "EUR", amount: NSDecimalNumber(string: "100"))
        let transaction5 = Transaction(sku: "SKU2", currency: "USD", amount: NSDecimalNumber(string: "200"))
        let transaction6 = Transaction(sku: "SKU3", currency: "EUR", amount: NSDecimalNumber(string: "300"))
        return [transaction1, transaction2, transaction3, transaction4, transaction5, transaction6]
    }
    
    var rates: [Rate] {
        let rate1 = Rate(from: "EUR", to: "USD", rate: NSDecimalNumber(string: "1.12"))
        let rate2 = Rate(from: "USD", to: "EUR", rate: NSDecimalNumber(string: "0.89"))
        return [rate1, rate2]
    }
}
