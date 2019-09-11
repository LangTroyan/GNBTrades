//
//  RatesCell.swift
//  GNB Trades
//
//  Created by Lang Troyan on 11/09/2019.
//  Copyright © 2019 Lang Troyan. All rights reserved.
//

import UIKit

class RateCell: UITableViewCell {
    
    public static let kIDENTIFIER = "RateCell"
    
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    
    var rate: Rate? {
        didSet {
            if let rate = rate {
                fromLabel.text = rate.from.rawValue
                toLabel.text = rate.to.rawValue
                if let rate = Double(rate.rate){
                    rateLabel.text = String(format: "%.2f", rate).replacingOccurrences(of: ".", with: ",")
                }
            }
            
        }
    }
}
