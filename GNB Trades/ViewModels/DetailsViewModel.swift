//
//  DetailsViewModel.swift
//  GNB Trades
//
//  Created by Lang Troyan on 11/09/2019.
//  Copyright © 2019 Lang Troyan. All rights reserved.
//

import Foundation

class DetailsViewModel {
    let transactions: [Transaction]
    let rates: [Rate]
    
    init(transactions: [Transaction], rates: [Rate]) {
        self.transactions = transactions
        self.rates = rates
    }
    
    public func convert(amount: Double, from: Currency, to: Currency) -> Double {
        if let rate = (rates.filter{ $0.from == from && $0.to == to }).first {
            if let rate = Double(rate.rate) {
                return (amount * rate * 100).rounded(.toNearestOrEven) / 100
            }
        }
        else {
            for rate in rates.filter({ $0.from == from }) {
                if let rate2 = (rates.filter{ $0.from == rate.from && $0.to == to }).first {
                    if let rateConversion = Double(rate.rate), let rateConversion2 = Double(rate2.rate) {
                        let conversion = (amount * rateConversion * 100).rounded(.toNearestOrEven) / 100
                        return (conversion * rateConversion2 * 100).rounded(.toNearestOrEven) / 100
                    }
                }
            }
        }
        return 0.00
    }
    
    public func getTotalSum() -> Double{
        var sum = 0.00
        for transaction in transactions {
            let amount = Double(transaction.amount) ?? 0.00
            sum += transaction.currency == Currency.EUR ? amount : convert(amount: amount, from: transaction.currency, to: Currency.EUR)
        }
        return (sum * 100).rounded(.toNearestOrEven) / 100
    }
}
