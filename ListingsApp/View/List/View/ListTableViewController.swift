//
//  ListTableViewController.swift
//  ListingsApp
//
//  Created by Oleg Gavrilich on 13.09.2020.
//  Copyright © 2020 Oleg Gavrilich. All rights reserved.
//

import UIKit

protocol ListTableViewProtocol: class {
    func setup(with listings: [Listing])
}

class ListTableViewController: UITableViewController, ListTableViewProtocol {
    
    var listingsData = [Listing]()
    var presenter: ListingViewPresenterProtocol = ListingViewPresenter()
    
    func setup(with listings: [Listing]) {
        self.listingsData = listings
        self.tableView.reloadData()
    }

    // MARK: - VC Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        presenter.start()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            guard let destinationVC = segue.destination as? DetailsTableViewController else {return}
            destinationVC.listing = listingsData[indexPath.row]
        }
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listingsData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listingCell", for: indexPath) as! ListingTableViewCell
        let listing = listingsData[indexPath.row]
        
        cell.titleLabel.text = listing.title
        return cell
    }
    
}
