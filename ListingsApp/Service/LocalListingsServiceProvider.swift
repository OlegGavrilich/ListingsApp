//
//  LocalListingsServiceProvider.swift
//  ListingsApp
//
//  Created by Oleg Gavrilich on 13.09.2020.
//  Copyright © 2020 Oleg Gavrilich. All rights reserved.
//

import Foundation

class LocalListingsServiceProvider: ListingsServiceProvider {
    
    private enum Constants {
        static let listingsJsonFile: String = "listings"
    }
    
    func getListings(completion: @escaping ([Listing]?) -> Void) {
        if let data = readLocalFile(for: Constants.listingsJsonFile) {
            let decoder = JSONDecoder()
            let result = try! decoder.decode([Listing].self, from: data)
            completion(result)
        } else {
            completion(nil)
        }
    }
    
    private func readLocalFile(for name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    
}
