//
//  RatioPresenterTests.swift
//  mokojin
//
//  Created by Yonatan Bergman on 3/25/15.
//  Copyright (c) 2015 iicninjas. All rights reserved.
import UIKit
import XCTest

class RatioPresenterTests: XCTestCase {
    
    let subject = Match()
    
    func ratio(expected:Double) -> String {
        subject["expected"] = expected
        return RatioPresenter.ratioString(subject)
    }
    
    func testEqual() {
        XCTAssertEqual("1:1", ratio(0.5))
    }
    
    func testSimple() {
        XCTAssertEqual("3:1", ratio(0.75))
    }

    func testSimpleReverse() {
        XCTAssertEqual("1:3", ratio(0.25))
    }

    func testRatioOneDecimal() {
        XCTAssertEqual("1.5:1", ratio(0.6))
    }
    
    func testRatioTwoDecimal() {
        XCTAssertEqual("1.25:1", ratio(0.5556))
    }

    func testRatioOne() {
        XCTAssertEqual("+∞:1", ratio(1))
    }
    
    func testRatioZero() {
        XCTAssertEqual("1:+∞", ratio(0))
    }

}
