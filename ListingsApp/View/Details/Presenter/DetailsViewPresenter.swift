//
//  DetailsViewPresenter.swift
//  ListingsApp
//
//  Created by Oleg Gavrilich on 14.09.2020.
//  Copyright © 2020 Oleg Gavrilich. All rights reserved.
//

import Foundation

protocol DetailsViewPresenterProtocol {
    var view: DetailsTableViewProtocol? { get set }
    
    func start(listing: Listing)
}

class DetailsViewPresenter: DetailsViewPresenterProtocol {
    weak var view: DetailsTableViewProtocol?
    
    func start(listing: Listing) {
        let progressSection = DetailsViewListSection(title: nil, items: [.progress(listing.progress.current)])
        let listingDetailsSection = DetailsViewListSection(title: "Listing Details", items: [.price("$\(listing.price)"),
                                                                                             .photos(String(listing.images.count))])
        let vehicleDetailsSection = DetailsViewListSection(title: "Vehicle Details", items: [.trim(listing.trim),
                                                                                             .features("Add Features"),
                                                                                             .transsmition(listing.transmission.rawValue),
                                                                                             .mileage(String(listing.mileage)),
                                                                                             .zipCode(String(listing.addresses.first?.zipcode ?? "No Zip Code provided"))])
        let contactInfoSection = DetailsViewListSection(title: "Contact Info", items: [.email(listing.owner.email ?? "No email provided"),
                                                                                       .phone(listing.phone)])
        let imageURLs = listing.images.map { (image) -> URL in
            image.url
        }
        
        let model = DetailsViewModel(
            price: "$\(Int(listing.price))",
            title: "\(listing.make) \(listing.model)",
            year: "\(listing.year)",
            mileage: "\(listing.mileage)",
            zipCode: "\(listing.addresses.first?.zipcode ?? "")",
            history: "History not available",
            imageURLs: imageURLs,
            sections: [progressSection,
                       listingDetailsSection,
                       vehicleDetailsSection,
                       contactInfoSection])
        view?.setup(with: model)
    }
}
