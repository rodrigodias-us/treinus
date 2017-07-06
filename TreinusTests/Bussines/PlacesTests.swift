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
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetPlaces() {
        Places.shared.getPlacesByLocation(location: <#T##String#>) { (place, error) in
            
        }
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
