//
//  MenuViewController.swift
//  GNB Trades
//
//  Created by Lang Troyan on 11/09/2019.
//  Copyright © 2019 Lang Troyan. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var ratesTableView: UITableView!
    
    var rates: [Rate]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ratesTableView.tableFooterView = UIView()
        loadRates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func loadRates() {
        showSpinner(onView: view)
        APIService().getData(from: .rates) { (result) in
            switch result {
            case .Success(let data):
                do {
                    let rates = try JSONDecoder().decode([Rate].self, from: data)
                    self.rates = rates
                    self.ratesTableView.reloadData()
                    self.removeSpinner()
                }
                catch ( _ ){
                    self.rates = [Rate]()
                    print("Could not parse the result.")
                    self.removeSpinner()
                }
            case .Error(let message):
                print(message)
                self.rates = [Rate]()
                print("Could not connect to the server.")
                self.removeSpinner()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case TransactionsViewController.kSEGUE:
            if let rates = sender as? [Rate], let vc = segue.destination as? TransactionsViewController {
                vc.rates = rates
            }
        default:
            break
        }
    }
    
    @IBAction func transactionsAction(_ sender: Any) {
        performSegue(withIdentifier: TransactionsViewController.kSEGUE, sender: rates)
    }
}

extension MenuViewController: UITableViewDelegate {
    
}

extension MenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rates?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = ratesTableView.dequeueReusableCell(withIdentifier: RateCell.kIDENTIFIER) as? RateCell, let rate = rates?[indexPath.row]{
            cell.rate = rate
            return cell
        }
        return ratesTableView.dequeueReusableCell(withIdentifier: RateCell.kIDENTIFIER)!
    }
    
    
}
