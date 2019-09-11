//
//  TransactionsViewModel.swift
//  GNB Trades
//
//  Created by Lang Troyan on 11/09/2019.
//  Copyright © 2019 Lang Troyan. All rights reserved.
//

import Foundation

class TransactionsViewModel {
    var transactions: [Transaction]?
    
    init(){
        
    }
    
    init(transactions: [Transaction]) {
        self.transactions = transactions
    }
    
    public func loadTransactions(successHandler: @escaping () -> Void, errorHandler: @escaping (String) -> Void) {
        APIService().getData(from: .transactions) { (result) in
            switch result {
            case .Success(let data):
                do {
                    let transactions = try JSONDecoder().decode([Transaction].self, from: data)
                    self.transactions = transactions
                    successHandler()
                }
                catch ( _ ){
                    self.transactions = [Transaction]()
                    errorHandler("Could not parse the result.")
                }
            case .Error(let message):
                print(message)
                self.transactions = [Transaction]()
                errorHandler("Could not connect to the server.")
            }
        }
    }
    
    public func getTransactions(of sku: String) -> [Transaction]? {
        return transactions?.filter{ $0.sku == sku}
    }
}
