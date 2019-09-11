//
//  Transaction.swift
//  GNB Trades
//
//  Created by Lang Troyan on 11/09/2019.
//  Copyright © 2019 Lang Troyan. All rights reserved.
//

import Foundation

struct Transaction: Codable {
    
    enum CodingKeys: String, CodingKey {
        case sku
        case amount
        case currency
    }
    
    var sku: String
    var amount: String
    var currency: Currency
    
    init(sku: String, amount: String, currency: Currency){
        self.sku = sku
        self.amount = amount
        self.currency = currency
    }
}
