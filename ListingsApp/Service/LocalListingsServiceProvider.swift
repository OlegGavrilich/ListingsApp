//
//  LocalListingsServiceProvider.swift
//  ListingsApp
//
//  Created by Oleg Gavrilich on 13.09.2020.
//  Copyright © 2020 Oleg Gavrilich. All rights reserved.
//

import UIKit

class LocalListingsServiceProvider: ListingsServiceProvider {
    
    private enum Constants {
        static let listingsJsonFile: String = "listings"
    }
    
    let imageCache = NSCache<AnyObject, AnyObject>()
    
    func getListings(completion: @escaping ([Listing]?) -> Void) {
        if let data = readLocalFile(for: Constants.listingsJsonFile) {
            let decoder = JSONDecoder()
            let result = try! decoder.decode([Listing].self, from: data)
            completion(result)
        } else {
            completion(nil)
        }
    }
    
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        if let image = imageCache.object(forKey: url as AnyObject) {
            completion(image as? UIImage)
        } else {
            URLSession.shared.dataTask(with: url) { (data, _, error) in
                guard let data = data, let imageData = UIImage(data: data) else {
                    completion(nil)
                    return
                }
                
                completion(imageData)
                self.imageCache.setObject(imageData, forKey: url as AnyObject)
            }.resume()
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
