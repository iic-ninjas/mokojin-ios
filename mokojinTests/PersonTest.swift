//
//  PersonTest.swift
//  mokojin
//
//  Created by Yonatan Bergman on 3/25/15.
//  Copyright (c) 2015 iicninjas. All rights reserved.
//

import XCTest

class PersonTest: XCTestCase {

    let objectId = "OBJECT_ID"
    var subject:Person!
    var newInstance:Person!
    var optionalPerson:Person?
    var differentPerson:Person!
    var dict:[Person:Bool]!
    
    override func setUp() {
        self.subject = Person(withoutDataWithObjectId: objectId)
        self.newInstance = Person(withoutDataWithObjectId: objectId)
        self.differentPerson = Person(withoutDataWithObjectId: objectId + "FOO")
        self.optionalPerson = Person(withoutDataWithObjectId: objectId)
        self.dict = [subject: true]
    }
    
    func testEquality() {
        XCTAssertEqual(subject, newInstance)
    }
    
    func testInequality() {
        XCTAssertNotEqual(subject, differentPerson)
    }
    
    func testHashiblity() {
        XCTAssertEqual(subject.hashValue, newInstance.hashValue)
    }
    
    func testDictionaryHashibility(){
        XCTAssertTrue(dict.indexForKey(newInstance) != nil)
        XCTAssertTrue(dict.indexForKey(differentPerson) == nil)
    }
    
    func testEqualityWithOptional() {
        XCTAssertTrue( subject == optionalPerson )
        XCTAssertTrue( optionalPerson == subject  )
    }

}
