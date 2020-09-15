//
//  Listing.swift
//  ListingsApp
//
//  Created by Oleg Gavrilich on 13.09.2020.
//  Copyright © 2020 Oleg Gavrilich. All rights reserved.
//

import Foundation

struct Listing: Decodable {
    
    enum Transmission: String, Decodable {
        case automatic
        case manual
    }
    
    struct Progress: Decodable {
        let current: Int
        let total: Int
    }
    
    struct Owner: Decodable {
        let last_name: String
        let id: String
        let photo_url: URL
        let first_name: String
        let email: String?
    }
    
    struct Address: Decodable {
        enum CodingKeys: String, CodingKey {
            case id
            case city
            case state
            case zipcode
            case latitude
            case longitude
        }
        
        let id: String?
        let city: String
        let state: String
        let zipcode: String
        let latitude: String
        let longitude: String
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decodeIfPresent(String.self, forKey: .id)
            city = try container.decode(String.self, forKey: .city)
            state = try container.decode(String.self, forKey: .state)
            zipcode = try container.decode(String.self, forKey: .zipcode)
            
            if let doubleLatitude = try? container.decode(Double.self, forKey: .latitude) {
                latitude = String(doubleLatitude)
            } else {
                latitude = try container.decode(String.self, forKey: .latitude)
            }
            
            if let doubleLongitude = try? container.decode(Double.self, forKey: .longitude) {
                longitude = String(doubleLongitude)
            } else {
                longitude = try container.decode(String.self, forKey: .longitude)
            }
        }
    }
    
    struct Image: Decodable {
        enum CodingKeys: String, CodingKey {
            case id
            case url
            case uri
        }
        
        let id: String
        let url: URL
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(String.self, forKey: .id)
            
            if let uri = try? container.decode(URL.self, forKey: .uri) {
                url = uri
            } else {
                url = try container.decode(URL.self, forKey: .url)
            }
        }
    }
    
    let id: String
    let vin: String
    let license_plate: String?
    let license_plate_state: String?
    let mileage: Double
    let phone: String
    let price: Double
    let short_url: String?
    let transmission: Transmission
    let title: String
    let trim: String
    let year: Int
    let model: String
    let make: String
    let progress: Progress
    let owner: Owner
    let addresses: [Address]
    let images: [Image]
}
