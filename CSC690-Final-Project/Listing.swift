//
//  Listing.swift
//  CSC690-Final-Project
//
//  Created by Alex Sergeev on 5/9/19.
//  Copyright © 2019 Alex Sergeev. All rights reserved.
//

import UIKit

class Listing: Codable {
    
    var title: String!
    var description: String!
    var price: Double!
    var housingType: String!
    var bedrooms: Int!
    var bathrooms: Int!
    // address
    var line1: String!
    var line2: String!
    var city: String!
    var state: String!
    var datePosted: String!
    var zipCode: Int!
    var isApproved: Bool!
    var images: [String]!
    
    init?(title: String, description: String,
          price: Double, housingType: String,
          bedrooms: Int, bathrooms: Int,
          line1: String, line2: String,
          city: String, state: String,
          zipCode: Int, isApproved: Bool, datePosted: String,
          images: [String]!) {
        self.title = title
        self.price = price
        self.housingType = housingType
        self.bathrooms = bathrooms
        self.bedrooms = bedrooms
        self.line1 = line1
        self.line2 = line2
        self.city = city
        self.state = state
        self.zipCode = zipCode
        self.isApproved = isApproved
        self.datePosted = datePosted
        self.images = images
    }
    
}
