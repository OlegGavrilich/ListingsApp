//
//  ListingViewPresenter.swift
//  ListingsApp
//
//  Created by Oleg Gavrilich on 15.09.2020.
//  Copyright © 2020 Oleg Gavrilich. All rights reserved.
//

import Foundation

protocol ListingViewPresenterProtocol {
    var view: ListTableViewProtocol? { get set }
    
    func start()
}

class ListingViewPresenter: ListingViewPresenterProtocol {
//    
    weak var view: ListTableViewProtocol?
    
    private var listingService: ListingsServiceProvider = LocalListingsServiceProvider()
    
    func start() {
        listingService.getListings { (listing) in
            if let listing = listing {
                self.view?.setup(with: listing)
            } else {
                print("something went wrong")
            }
        }
    }
}
