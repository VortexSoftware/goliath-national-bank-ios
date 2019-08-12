//
//  CurrencyConverterTest.swift
//  GoliathNationalBankTests
//
//  Created by Gastón Sobrevilla on 11/08/2019.
//  Copyright © 2019 Goliath National Bank. All rights reserved.
//

import XCTest
@testable import GoliathNationalBank

class CurrencyConverterTest: XCTestCase {
    
    func testConvertionWithDirectConvertionRate() {
        let converter = CurrencyConverter(rates: directRates)
        XCTAssertEqual(converter.convert(NSDecimalNumber(string: "10"), from: "USD", to: "ARS")?.stringValue, "456.7")
        XCTAssertEqual(converter.convert(NSDecimalNumber(string: "1000"), from: "ARS", to: "USD")?.stringValue, "21.9")
    }
    
    func testConvertionWithIndirectConvertionRate() {
        let converter = CurrencyConverter(rates: indirectRates)
        XCTAssertEqual(converter.convert(NSDecimalNumber(string: "1000"), from: "ARS", to: "NZD")?.stringValue, "33.94")
        XCTAssertEqual(converter.convert(NSDecimalNumber(string: "10"), from: "NZD", to: "ARS")?.stringValue, "296.86")
    }
    
    func testConvertionWithNoRate() {
        let converter = CurrencyConverter(rates: directRates)
        XCTAssertNil(converter.convert(NSDecimalNumber(string: "1000"), from: "ARS", to: "NZD"))
        XCTAssertNil(converter.convert(NSDecimalNumber(string: "10"), from: "NZD", to: "ARS"))
    }
    
    func testConvertionWithEmptyRates() {
        let converter = CurrencyConverter(rates: [])
        XCTAssertNil(converter.convert(NSDecimalNumber(string: "1000"), from: "ARS", to: "NZD"))
        XCTAssertNil(converter.convert(NSDecimalNumber(string: "10"), from: "NZD", to: "ARS"))
    }
    
    func testConvertionWithEqualCurrencies() {
        let converter = CurrencyConverter(rates: [])
        XCTAssertNotNil(converter.convert(NSDecimalNumber(string: "1000"), from: "ARS", to: "ARS"))
        XCTAssertEqual(converter.convert(NSDecimalNumber(string: "1000"), from: "ARS", to: "ARS")?.stringValue, "1000")
    }
}

extension CurrencyConverterTest {
    
    var directRates: [Rate] { // ARS-USD
        let rate1 = Rate(from: "ARS", to: "USD", rate: NSDecimalNumber(string: "0.0219"))
        let rate2 = Rate(from: "USD", to: "ARS", rate: NSDecimalNumber(string: "45.67"))
        return [rate1, rate2]
    }
    
    var indirectRates: [Rate] { // ARS-USD and NZD-USD
        let rate1 = Rate(from: "ARS", to: "USD", rate: NSDecimalNumber(string: "0.0219"))
        let rate2 = Rate(from: "USD", to: "ARS", rate: NSDecimalNumber(string: "45.67"))
        let rate3 = Rate(from: "USD", to: "NZD", rate: NSDecimalNumber(string: "1.55"))
        let rate4 = Rate(from: "NZD", to: "USD", rate: NSDecimalNumber(string: "0.65"))
        return [rate1, rate2, rate3, rate4]
    }
}
