//
//  ListingsServiceProvider.swift
//  ListingsApp
//
//  Created by Oleg Gavrilich on 13.09.2020.
//  Copyright © 2020 Oleg Gavrilich. All rights reserved.
//

import Foundation

protocol ListingsServiceProvider {
    func getListings(completion: @escaping ([Listing]?) -> Void)
}
