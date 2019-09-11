//
//  Rate.swift
//  GNB Trades
//
//  Created by Lang Troyan on 11/09/2019.
//  Copyright © 2019 Lang Troyan. All rights reserved.
//

import Foundation

struct Rate: Codable {
    var from: Currency
    var to: Currency
    var rate: String
    
    enum CodingKeys: String, CodingKey {
        case from
        case to
        case rate
    }
    
    init(from: Currency, to: Currency, rate: String) {
        self.from = from
        self.to = to
        self.rate = rate
    }
}
