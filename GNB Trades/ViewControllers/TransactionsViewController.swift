//
//  ViewController.swift
//  GNB Trades
//
//  Created by Lang Troyan on 11/09/2019.
//  Copyright © 2019 Lang Troyan. All rights reserved.
//

import UIKit

class TransactionsViewController: UIViewController {

    public static let kSEGUE = "TransactionsSegue"
    
    @IBOutlet weak var transactionsTableView: UITableView!
    
    var viewModel: TransactionsViewModel
    var rates: [Rate]?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        viewModel = TransactionsViewModel()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        viewModel = TransactionsViewModel()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadTransactions()
    }
    
    func loadTransactions(){
        showSpinner(onView: view)
        viewModel.loadTransactions(successHandler: {
            self.removeSpinner()
            self.transactionsTableView.reloadData()
        }) { (_) in
            self.removeSpinner()
            self.showAlertWith(title: "Error", message: "Could not load any transaction. Check your internet connection.", completition: {
                self.loadTransactions()
            })
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch(segue.identifier){
        case DetailsViewController.kSEGUE:
            if let detailsVC = segue.destination as? DetailsViewController, let transactions = sender as? [Transaction] {
                detailsVC.viewModel = DetailsViewModel(transactions: transactions, rates: rates!)
            }
        default:
            break
        }
    }

}

extension TransactionsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let sku = viewModel.transactions?[indexPath.row].sku, let transactions = viewModel.getTransactions(of: sku) {
            performSegue(withIdentifier: DetailsViewController.kSEGUE, sender: transactions)
        }
    }
}

extension TransactionsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.transactions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = transactionsTableView.dequeueReusableCell(withIdentifier: TransactionCell.kIDENTIFIER) as? TransactionCell{
            cell.transaction = viewModel.transactions?[indexPath.row]
            return cell
        }
        return transactionsTableView.dequeueReusableCell(withIdentifier: TransactionCell.kIDENTIFIER)!
    }
    
    
}
