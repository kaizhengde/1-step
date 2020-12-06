//
//  GoalEditTests.swift
//  1 Step Tests
//
//  Created by Kai Zheng on 06.12.20.
//

@testable import __Step
import XCTest

final class GoalEditTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }


    override func tearDown() {
        let expectationDelete  = XCTestExpectation(description: "Delete")
        GoalTestsModel.deleteAllGoals { expectationDelete.fulfill() }
        wait(for: [expectationDelete], timeout: 60.0)
        super.tearDown()
    }
    
    
    

}
