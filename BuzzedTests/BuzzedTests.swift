//
//  BuzzedTests.swift
//  BuzzedTests
//
//  Created by Drew Lanning on 2/18/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import XCTest

class BuzzedTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    let dm = DataManager()
    dm.clearUserDefaults()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func testCaffeineSource() {
    let source = CaffeineSource(type: .dripCoffee, volume: 16.0)
    XCTAssert(source.sourceName == CaffeineSourceType.dripCoffee.getName())
    XCTAssert(source.sourceDescription == CaffeineSourceType.dripCoffee.getDescription())
    XCTAssert(source.baseUnit == UnitVolume.fluidOunces)
    XCTAssert(source.volume == 16.0)
    XCTAssert(source.mgCaffeinePerVolume == 15.0)
    XCTAssert(source.totalCaffeineContent == 240.0)
    XCTAssert(source.associatedImageName == "16oz Cup - Brown")
    
    source.toggleMetricOrCustomary()
    XCTAssert(source.baseUnit == UnitVolume.milliliters)
    XCTAssert(source.volume == 473.18)
    XCTAssert(source.mgCaffeinePerVolume == 0.51)
    XCTAssert(source.totalCaffeineContent == 241.32)
    
    source.consume(50.0)
    XCTAssert(source.totalCaffeineConsumed() == 241.32/2)
    
    source.consume(25.0)
    XCTAssert(source.totalCaffeineConsumed() == 241.32/4)
    
    source.consume(100.0)
    XCTAssert(source.totalCaffeineConsumed() == 241.32)
    
    source.toggleMetricOrCustomary()
    XCTAssert(source.baseUnit == UnitVolume.fluidOunces)
    XCTAssert(source.volume == 16.0)
  }
  
  func testPerformanceExample() {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
}
