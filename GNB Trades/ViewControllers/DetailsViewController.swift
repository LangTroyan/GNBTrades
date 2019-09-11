//
//  DetailsViewController.swift
//  GNB Trades
//
//  Created by Lang Troyan on 11/09/2019.
//  Copyright © 2019 Lang Troyan. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    public static let kSEGUE = "DetailsSegue"
    
    @IBOutlet weak var transactionsTableView: UITableView!
    @IBOutlet weak var totalSumLabel: UILabel!
    
    var viewModel: DetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        totalSumLabel.text = "\(viewModel?.getTotalSum() ?? 0.00)".replacingOccurrences(of: ".", with: ",")
    }
}

extension DetailsViewController: UITableViewDelegate {
    
}

extension DetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.transactions.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = transactionsTableView.dequeueReusableCell(withIdentifier: TransactionCell.kIDENTIFIER) as? TransactionCell, let transaction = viewModel?.transactions[indexPath.row] {
            cell.transaction = transaction
            return cell
        }
        return transactionsTableView.dequeueReusableCell(withIdentifier: TransactionCell.kIDENTIFIER)!
    }
    
    
}
