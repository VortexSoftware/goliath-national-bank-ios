//
//  ProductsListViewModel.swift
//  GoliathNationalBank
//
//  Created by Gastón Sobrevilla on 11/08/2019.
//  Copyright © 2019 Goliath National Bank. All rights reserved.
//

import Foundation

protocol ProductsListViewModelProtocol: class {
    func fetchProductsList()
    func fetchDetailFor(sku: String)
}

protocol ProductsListViewProtocol: class {
    func updateProductsList(products: [Product])
    func updateProductDetail(product: Product)
    func showError(message: String?)
}

class ProductsListViewModel: ProductsListViewModelProtocol {
    
    weak var view: ProductsListViewProtocol?
    
    let transactionsRepository: TransactionsRepository
    let ratesRepository: RatesRepository
    
    var transactions: [Transaction] = []
    var rates: [Rate] = []
    
    init(view: ProductsListViewProtocol, transactionsRepository: TransactionsRepository, ratesRepository: RatesRepository) {
        self.view = view
        self.transactionsRepository = transactionsRepository
        self.ratesRepository = ratesRepository
    }
    
    func fetchProductsList() {
        fetchTransactions { [weak self] in
            self?.fetchRates {
                self?.processFetchingResults()
            }
        }
    }
    
    func fetchDetailFor(sku: String) {
        let manager = TransactionsManager(transactions: transactions, rates: rates)
        let product = manager.getProductWithTransactions(for: sku)
        view?.updateProductDetail(product: product)
    }
    
    private func fetchTransactions(completion: @escaping () -> Void) {
        transactionsRepository.getTransactionsList { [weak self] (success, transactions, error) in
            guard let self = self else { return }
            guard success else {
                self.view?.showError(message: error?.message)
                return
            }
            self.transactions = transactions ?? []
            completion()
        }
    }
    
    private func fetchRates(completion: @escaping () -> Void) {
        ratesRepository.getRatesList { [weak self] (success, rates, error) in
            guard let self = self else { return }
            guard success else {
                self.view?.showError(message: error?.message)
                return
            }
            self.rates = rates ?? []
            completion()
        }
    }
    
    private func processFetchingResults() {
        let manager = TransactionsManager(transactions: transactions, rates: rates)
        view?.updateProductsList(products: manager.getProductsWithoutTransactions())
    }
}
