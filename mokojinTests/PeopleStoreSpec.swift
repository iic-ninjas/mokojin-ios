//
//  PeopleStoreTest.swift
//  mokojin
//
//  Created by Yonatan Bergman on 3/26/15.
//  Copyright (c) 2015 iicninjas. All rights reserved.
//

import Foundation
import Quick
import Nimble

class PeopleStoreSpec : QuickSpec {
    
    override func spec() {
        
        let subject = PeopleStore.sharedInstance
        
        describe("initialization"){
            it("should be not loaded right on load"){
                expect(subject.loaded).to(beFalse())
            }
            it("should have an empty array"){
                expect(PeopleStore.sharedInstance.people).to(beEmpty())
            }
        }
        
        describe("forceUpdate"){
            it("should set loaded to false"){
                expect(subject.forceUpdate().loaded).to(beFalse())
            }
            it("should set notify when done"){
                subject.forceUpdate()
                expect(subject.loaded).toEventually(beTrue(), timeout: 3)
                expect(subject.people).toEventuallyNot(beEmpty(), timeout: 3)
            }
            
            context("getter broken"){
                it("should not update"){
                    let innerSubject = _PeopleStore()
                    innerSubject.forceUpdate()
                    expect(innerSubject.loaded).toEventuallyNot(beTrue(), timeout: 3)
                    expect(innerSubject.people).toEventually(beEmpty(), timeout: 3)
                }
            }

        }
    }
    
    
    class MockGetPeople : GetPeople {
        override func get(callback: (People)->()){
            // Do Nothing
        }
    }
    class _PeopleStore : PeopleStore {
        internal init(){
            super.init(getter: MockGetPeople())
        }
    }
}
