//
//  CSC690_Final_ProjectTests.swift
//  CSC690-Final-ProjectTests
//
//  Created by Alex Sergeev on 5/5/19.
//  Copyright © 2019 Alex Sergeev. All rights reserved.
//

import XCTest
@testable import CSC690_Final_Project

class ListingModelTests: XCTestCase {
    
    func testListingInitializationSucceeds(){
        let listing = Listing.init(title: "Test", description: "Test", price: 20.01, housingType: "Test", bedrooms: 2, bathrooms: 1, line1: "Test", line2: "Test", city: "San Francisco", state: "CA", zipCode: 10001, isApproved: false, datePosted: "May 9th", images: ["hello"])
        XCTAssertNotNil(listing)
    }
    
}
