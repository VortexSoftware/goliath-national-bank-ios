//
//  CurrencyConverter.swift
//  GoliathNationalBank
//
//  Created by Gastón Sobrevilla on 11/08/2019.
//  Copyright © 2019 Goliath National Bank. All rights reserved.
//

import Foundation

class CurrencyConverter {
    
    private let rates: [Rate]
    
    init(rates: [Rate]) {
        self.rates = rates
    }
    
    func convert(_ amount: NSDecimalNumber, from originCurrency: String, to destinationCurrenty: String) -> NSDecimalNumber? {
        if originCurrency == destinationCurrenty {
            return amount
        }
        
        if let directRate = getDirectRate(from: originCurrency, to: destinationCurrenty) {
            // Direct convertion
            return rounding(amount.multiplying(by: directRate))
        } else if let indirectRate = getIndirectRate(from: originCurrency, to: destinationCurrenty) {
            // Indirect convertion
            return rounding(amount.multiplying(by: indirectRate))
        } else {
            // No rate available
            return nil
        }
    }
    
    private func getDirectRate(from originCurrency: String, to destinationCurrenty: String) -> NSDecimalNumber? {
        // Rate from originCurrency to destinationCurrenty
        guard let rateObj = (rates.first { $0.from == originCurrency && $0.to == destinationCurrenty }) else { return nil }
        guard let rate = rateObj.rate else { return nil }
        return rate
    }
    
    private func getIndirectRate(from originCurrency: String, to destinationCurrenty: String) -> NSDecimalNumber? {
        // Rate from originCurrency to X
        guard let firstRateObj = (rates.first { $0.from == originCurrency }) else { return nil }
        
        // Rate from X to destinationCurrenty
        guard let secondRateObj = (rates.first { $0.from == firstRateObj.to && $0.to == destinationCurrenty }) else { return nil }
        
        guard let firstRate = firstRateObj.rate, let secondRate = secondRateObj.rate else { return nil }
        let finalRate = firstRate.multiplying(by: secondRate)
        return finalRate
    }
    
    private func rounding(_ number: NSDecimalNumber) -> NSDecimalNumber {
        return number.rounding(accordingToBehavior: NSDecimalNumberHandler(roundingMode: .bankers, scale: 2, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false))
    }
}
