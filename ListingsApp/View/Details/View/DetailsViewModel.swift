//
//  DetailsViewModel.swift
//  ListingsApp
//
//  Created by Oleg Gavrilich on 14.09.2020.
//  Copyright © 2020 Oleg Gavrilich. All rights reserved.
//

import Foundation

enum DetailsViewListItem {
    case progress(Int)
    case price(String)
    case photos(String)
    case trim(String)
    case features(String)
    case transsmition(String)
    case mileage(String)
    case zipCode(String)
    case email(String)
    case phone(String)
}

struct DetailsViewListSection {
    let title: String?
    let items: [DetailsViewListItem]
}

struct DetailsViewModel {
    let price: String
    let title: String
    let year: String
    let mileage: String
    let zipCode: String
    let history: String
    let imageURLs: [URL]
    let sections: [DetailsViewListSection]
}
