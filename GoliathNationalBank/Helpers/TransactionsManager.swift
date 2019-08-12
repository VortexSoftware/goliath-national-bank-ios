//
//  TransactionsManager.swift
//  GoliathNationalBank
//
//  Created by Gastón Sobrevilla on 11/08/2019.
//  Copyright © 2019 Goliath National Bank. All rights reserved.
//

import Foundation

class TransactionsManager {
    
    private let transactions: [Transaction]
    private let rates: [Rate]
    private lazy var converter = CurrencyConverter(rates: rates)
    
    init(transactions: [Transaction], rates: [Rate]) {
        self.transactions = transactions
        self.rates = rates
    }
    
    func getProductsWithoutTransactions() -> [Product] {
        let skus = transactions.compactMap({ $0.sku })
        var uniqueSkus: [String] = []
        skus.forEach { (sku) in
            guard !uniqueSkus.contains(sku) else { return }
            uniqueSkus.append(sku)
        }
        return uniqueSkus.map({ Product(sku: $0) })
    }
    
    func getProductWithTransactions(for sku: String) -> Product {
        let skuTransactions = transactions.filter { (transaction) -> Bool in
            return transaction.sku == sku
        }
        
        var total = NSDecimalNumber.zero
        skuTransactions.forEach { (transaction) in
            guard let amount = transaction.amount, let currency = transaction.currency else { return }
            if let amountInEur = converter.convert(amount, from: currency, to: "EUR") {
                total = total.adding(amountInEur)
            }
        }
        
        return Product(sku: sku, total: total, transactions: skuTransactions)
    }
}
