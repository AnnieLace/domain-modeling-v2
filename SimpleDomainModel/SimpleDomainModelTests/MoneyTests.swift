//
//  MoneyTests.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import XCTest

import SimpleDomainModel

//////////////////
// MoneyTests
//
class MoneyTests: XCTestCase {
  
  let tenUSD = Money(amount: 10, currency: "USD")
  let twelveUSD = Money(amount: 12, currency: "USD")
  let fiveGBP = Money(amount: 5, currency: "GBP")
  let fifteenEUR = Money(amount: 15, currency: "EUR")
  let fifteenCAN = Money(amount: 15, currency: "CAN")
    
  func testCanICreateMoney() {
    let oneUSD = Money(amount: 1, currency: "USD")
    XCTAssert(oneUSD.amount == 1)
    XCTAssert(oneUSD.currency == "USD")
    
    let tenGBP = Money(amount: 10, currency: "GBP")
    XCTAssert(tenGBP.amount == 10)
    XCTAssert(tenGBP.currency == "GBP")
  }
  
    func testDescription() {
        XCTAssert(tenUSD.description == "10 USD")
        XCTAssert(twelveUSD.description == "12 USD")
        XCTAssert(fiveGBP.description == "5 GBP")
        XCTAssert(fifteenEUR.description == "15 EUR")
        XCTAssert(fifteenCAN.description == "15 CAN")
    }
    
    func testPlusOperatorSameCurrency() {
        let usd = tenUSD + tenUSD
        XCTAssert(usd.amount == 20)
        XCTAssert(usd.currency == "USD")
    }
    
    func testPlusOperatorDiffCurrency() {
        let someMoney = tenUSD + fiveGBP
        XCTAssert(someMoney.amount == 20)
        XCTAssert(someMoney.currency == "USD")
    }
    
    func testMinusOperatorSameCurrency() {
        let usd = twelveUSD - tenUSD
        XCTAssert(usd.amount == 2)
        XCTAssert(usd.currency == "USD")
    }
    
    func testMinusOperatorDiffCurrency() {
        let someMoney = tenUSD - fiveGBP
        XCTAssert(someMoney.amount == 0)
        XCTAssert(someMoney.currency == "USD")
    }
    
    func testDoubleExtensionUSD() {
        let usd = 10.0.USD
        XCTAssert(usd.amount == 10)
        XCTAssert(usd.currency == "USD")
    }
    
    func testDoubleExtensionEUR() {
        let eur = 8.7.EUR
        XCTAssert(eur.amount == 8)
        XCTAssert(eur.currency == "EUR")
    }
    
    func testDoubleExtensionGBP() {
        let gbp = 5.0.GBP
        XCTAssert(gbp.amount == 5)
        XCTAssert(gbp.currency == "GBP")
    }
    
    func testDoubleExtensionYEN() {
        let yen = 6.2.YEN
        XCTAssert(yen.amount == 6)
        XCTAssert(yen.currency == "YEN")
    }
    
  func testUSDtoGBP() {
    let gbp = tenUSD.convert("GBP")
    XCTAssert(gbp.currency == "GBP")
    XCTAssert(gbp.amount == 5)
    XCTAssert(gbp.description == "5 GBP")
  }
  func testUSDtoEUR() {
    let eur = tenUSD.convert("EUR")
    XCTAssert(eur.currency == "EUR")
    XCTAssert(eur.amount == 15)
    XCTAssert(eur.description == "15 EUR")
  }
  func testUSDtoCAN() {
    let can = twelveUSD.convert("CAN")
    XCTAssert(can.currency == "CAN")
    XCTAssert(can.amount == 15)
    XCTAssert(can.description == "15 CAN")
  }
  func testGBPtoUSD() {
    let usd = fiveGBP.convert("USD")
    XCTAssert(usd.currency == "USD")
    XCTAssert(usd.amount == 10)
    XCTAssert(usd.description == "10 USD")
  }
  func testEURtoUSD() {
    let usd = fifteenEUR.convert("USD")
    XCTAssert(usd.currency == "USD")
    XCTAssert(usd.amount == 10)
  }
  func testCANtoUSD() {
    let usd = fifteenCAN.convert("USD")
    XCTAssert(usd.currency == "USD")
    XCTAssert(usd.amount == 12)
  }
  
  func testUSDtoEURtoUSD() {
    let eur = tenUSD.convert("EUR")
    let usd = eur.convert("USD")
    XCTAssert(tenUSD.amount == usd.amount)
    XCTAssert(tenUSD.currency == usd.currency)
    XCTAssert(tenUSD.description == usd.description)
  }
  func testUSDtoGBPtoUSD() {
    let gbp = tenUSD.convert("GBP")
    let usd = gbp.convert("USD")
    XCTAssert(tenUSD.amount == usd.amount)
    XCTAssert(tenUSD.currency == usd.currency)
  }
  func testUSDtoCANtoUSD() {
    let can = twelveUSD.convert("CAN")
    let usd = can.convert("USD")
    XCTAssert(twelveUSD.amount == usd.amount)
    XCTAssert(twelveUSD.currency == usd.currency)
  }
  
  func testAddUSDtoUSD() {
    let total = tenUSD.add(tenUSD)
    XCTAssert(total.amount == 20)
    XCTAssert(total.currency == "USD")
    XCTAssert(total.description == "20 USD")
  }
  
  func testAddUSDtoGBP() {
    let total = tenUSD.add(fiveGBP)
    XCTAssert(total.amount == 10)
    XCTAssert(total.currency == "GBP")
    XCTAssert(total.description == "10 GBP")
  }
}

