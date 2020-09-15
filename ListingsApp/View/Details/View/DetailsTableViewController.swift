//
//  DetailsTableViewController.swift
//  ListingsApp
//
//  Created by Oleg Gavrilich on 13.09.2020.
//  Copyright © 2020 Oleg Gavrilich. All rights reserved.
//

import UIKit

protocol DetailsTableViewProtocol: class {
    func setup(with model: DetailsViewModel)
}

class DetailsTableViewController: UITableViewController, DetailsTableViewProtocol {
    
    // MARK: - Properties
    
    var listing: Listing?
    var presenter: DetailsViewPresenterProtocol = DetailsViewPresenter()
    var provider: ListingsServiceProvider = LocalListingsServiceProvider()

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var modelName: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var mileage: UILabel!
    @IBOutlet weak var zipCode: UILabel!
    @IBOutlet weak var history: UILabel!
    
    var imageViews: [UIImageView] = []
    
    var model: DetailsViewModel?
    
    // MARK: - VC Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        year.layer.borderWidth = 1
        year.layer.borderColor = #colorLiteral(red: 0.7137254902, green: 0.7411764706, blue: 0.7764705882, alpha: 1)
        year.layer.cornerRadius = 3
        
        presenter.view = self
        if let listing = listing {
            presenter.start(listing: listing)
        }
    }
    
    func setup(with model: DetailsViewModel) {
        self.model = model
        price.text = model.price
        modelName.text = model.title
        year.text = model.year
        mileage.text = model.mileage
        zipCode.text = model.zipCode
        history.text = model.history
        setupImageScrollView(with: model.imageURLs)
        tableView.reloadData()
    }
    
    private func setupImageScrollView(with images: [URL]) {
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width * CGFloat(images.count),
                                        height: scrollView.frame.size.height)
        
        for index in 0..<images.count {
            var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            frame.origin.x = scrollView.frame.size.width * CGFloat(index)
            frame.size = scrollView.frame.size
            
            let imageView = UIImageView(frame: frame)
            imageView.contentMode = .scaleAspectFit
            imageViews.append(imageView)
            
            scrollView.addSubview(imageView)
        }
        
        for index in 0..<images.count {
            provider.loadImage(from: images[index]) { image in
                DispatchQueue.main.async {
                    self.imageViews[index].image = image
                }
            }
        }
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return model?.sections.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.sections[section].items.count ?? 0
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return model?.sections[section].title
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = model?.sections[indexPath.section].items[indexPath.row] else {
            return UITableViewCell()
        }
        
        switch item {
        case .progress(let progress):
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProgressTableViewCell") as! ProgressTableViewCell
            cell.configure(with: progress, progressBar: Float(progress))
            return cell
        case .price(let price):
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell") as! DetailsTableViewCell
            cell.configure(with: "Price", secondaryTitle: price)
            return cell
        case .photos(let photos):
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell") as! DetailsTableViewCell
            cell.configure(with: "Photos", secondaryTitle: photos)
            return cell
        case .trim(let trim):
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell") as! DetailsTableViewCell
            cell.configure(with: "Trim", secondaryTitle: trim)
            return cell
        case .features:
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell") as! DetailsTableViewCell
            cell.configure(with: "Features", secondaryTitle: "Add features")
            return cell
        case .transsmition(let transmission):
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell") as! DetailsTableViewCell
            cell.configure(with: "Transmission", secondaryTitle: transmission)
            return cell
        case .mileage(let mileage):
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell") as! DetailsTableViewCell
            cell.configure(with: "Mileage", secondaryTitle: mileage)
            return cell
        case .zipCode(let zipCode):
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell") as! DetailsTableViewCell
            cell.configure(with: "Zip Code", secondaryTitle: zipCode)
            return cell
        case .email(let email):
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell") as! DetailsTableViewCell
            cell.configure(with: "Email", secondaryTitle: email)
            return cell
        case .phone(let phone):
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell") as! DetailsTableViewCell
            cell.configure(with: "Phone", secondaryTitle: phone)
            return cell
        }

    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.tintColor = .clear
        header.textLabel?.textColor = UIColor.gray
        header.textLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 13)
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
