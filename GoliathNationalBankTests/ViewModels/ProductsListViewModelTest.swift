//
//  ProductsListViewModelTest.swift
//  GoliathNationalBankTests
//
//  Created by Gastón Sobrevilla on 11/08/2019.
//  Copyright © 2019 Goliath National Bank. All rights reserved.
//

import XCTest
@testable import GoliathNationalBank

class ProductsListViewModelTest: XCTestCase {
    
    fileprivate let view = MockedView()
    var viewModel: ProductsListViewModel!
    
    func testSuccess() {
        let viewModel = ProductsListViewModel(
            view: view,
            transactionsRepository: MockedTransactionsRepository(),
            ratesRepository: MockedRatesRepository())
        
        view.viewModel = viewModel
        
        viewModel.fetchProductsList()
        wait(for: [view.updateProductsListExpectation], timeout: 1)
        wait(for: [view.updateProductDetailExpectation], timeout: 1)
    }
}

fileprivate class MockedView: ProductsListViewProtocol {
    
    var viewModel: ProductsListViewModelProtocol!
    
    let updateProductsListExpectation = XCTestExpectation(description: "updateProductsList")
    let updateProductDetailExpectation = XCTestExpectation(description: "updateProductDetail")
    
    func updateProductsList(products: [Product]) {
        XCTAssertEqual(products.count, 2)
        XCTAssertEqual(products.map({ $0.sku }), ["SKU1", "SKU2"])
        updateProductsListExpectation.fulfill()
        viewModel.fetchDetailFor(sku: "SKU1")
    }
    
    func updateProductDetail(product: Product) {
        XCTAssertEqual(product.sku, "SKU1")
        XCTAssertEqual(product.total?.stringValue, "10.54")
        XCTAssertEqual(product.transactions?.count, 1)
        XCTAssertEqual(product.transactions?.first?.amount?.stringValue, "10.54")
        updateProductDetailExpectation.fulfill()
    }
    
    func showError(message: String?) {
        
    }
}

fileprivate class MockedTransactionsRepository: TransactionsRepository {
    func getTransactionsList(completion: @escaping TransactionsArrayCompletion) {
        let t1 = Transaction(sku: "SKU1", currency: "EUR", amount: NSDecimalNumber(string: "10.54"))
        let t2 = Transaction(sku: "SKU2", currency: "EUR", amount: NSDecimalNumber(string: "2.43"))
        completion(true, [t1, t2], nil)
    }
}

fileprivate class MockedRatesRepository: RatesRepository {
    func getRatesList(completion: @escaping RatesArrayCompletion) {
        let r1 = Rate(from: "EUR", to: "USD", rate: NSDecimalNumber(string: "1.12"))
        let r2 = Rate(from: "USD", to: "EUR", rate: NSDecimalNumber(string: "0.89"))
        completion(true, [r1, r2], nil)
    }
}
