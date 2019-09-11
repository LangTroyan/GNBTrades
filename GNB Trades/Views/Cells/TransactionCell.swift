//
//  TransactionCell.swift
//  GNB Trades
//
//  Created by Lang Troyan on 11/09/2019.
//  Copyright © 2019 Lang Troyan. All rights reserved.
//

import Foundation
import UIKit

class TransactionCell: UITableViewCell {
    
    public static let kIDENTIFIER = "TransactionCell"
    
    @IBOutlet weak var skuLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    
    var transaction: Transaction? {
        didSet {
            if let transaction = transaction {
                skuLabel.text = transaction.sku
                let amount = Double(transaction.amount)
                amountLabel.text = String(format: "%.2f", amount ?? 0.0).replacingOccurrences(of: ".", with: ",")
                currencyLabel.text = transaction.currency.rawValue
            }
            
        }
    }
    

}
