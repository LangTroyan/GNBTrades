//
//  APIService.swift
//  GNB Trades
//
//  Created by Lang Troyan on 11/09/2019.
//  Copyright © 2019 Lang Troyan. All rights reserved.
//

import UIKit

enum Result<T>{
    case Success(T)
    case Error(String)
}

class APIService: NSObject {
    
    enum Route: String {
        case rates = "/rates.json"
        case transactions = "/transactions.json"
    }
    
    //MARK: Properties
    let baseUrl: String = "https://quiet-stone-2094.herokuapp.com"
    
    //MARK: Method
    func getData(from route: Route, completition: @escaping (Result<Data>) -> Void){
        guard let url = URL(string: baseUrl + route.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else { return completition(.Error(error?.localizedDescription ?? "Invalid URL")) }
            guard let data = data else { return completition(.Error(error?.localizedDescription ?? "No data to show")) }
            
            DispatchQueue.main.async {
                completition(.Success(data))
            }
        }.resume()
    }
}
