//
//  PlacesTests.swift
//  Treinus
//
//  Created by Rodrigo Dias on 05/07/17.
//  Copyright © 2017 Rodrigo Dias. All rights reserved.
//

import XCTest
@testable import Treinus

class PlacesTests: XCTestCase {
    
    func testGetPlaces() {
        let expectation = self.expectation(description: "Fetch Places")
        
        Places.shared.getPlacesByLocation(location: "-33.8670, 151.1957") { (places, error) in
            XCTAssertNil(error)
            XCTAssertGreaterThan((places?.count)!, 0)
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 5.0, handler: nil)
    }
    
}
