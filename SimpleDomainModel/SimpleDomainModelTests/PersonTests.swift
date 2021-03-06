//
//  PersonTests.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import XCTest

class PersonTests: XCTestCase {

  func testPerson() {
    let ted = Person(firstName: "Ted", lastName: "Neward", age: 45)
    XCTAssert(ted.toString() == "[Person: firstName:Ted lastName:Neward age:45 job:nil spouse:nil]")
    XCTAssert(ted.description == "[Person: firstName:Ted lastName:Neward age:45 job:nil spouse:nil]")
  }
    
  func testAgeRestrictions() {
    let matt = Person(firstName: "Matthew", lastName: "Neward", age: 15)
    
    matt.job = Job(title: "Burger-Flipper", type: Job.JobType.Hourly(5.5))
    XCTAssert(matt.job == nil)

    matt.spouse = Person(firstName: "Bambi", lastName: "Jones", age: 42)
    XCTAssert(matt.spouse == nil)
    
    XCTAssert(matt.description == "[Person: firstName:Matthew lastName:Neward age:15 job:nil spouse:nil]")
  }
  
  func testAdultAgeRestrictions() {
    let mike = Person(firstName: "Michael", lastName: "Neward", age: 22)
    
    mike.job = Job(title: "Burger-Flipper", type: Job.JobType.Hourly(5.5))
    XCTAssert(mike.job != nil)
    
    mike.spouse = Person(firstName: "Bambi", lastName: "Jones", age: 42)
    XCTAssert(mike.spouse != nil)
    
    XCTAssert(mike.description == "[Person: firstName:Michael lastName:Neward age:22 job:Burger-Flipper spouse:Bambi]")
    }
  
}

class FamilyTests : XCTestCase {
  
  func testFamily() {
    let ted = Person(firstName: "Ted", lastName: "Neward", age: 45)
    ted.job = Job(title: "Gues Lecturer", type: Job.JobType.Salary(1000))
    XCTAssert(ted.description == "[Person: firstName:Ted lastName:Neward age:45 job:Gues Lecturer spouse:nil]")
    
    let charlotte = Person(firstName: "Charlotte", lastName: "Neward", age: 45)
    
    let family = Family(spouse1: ted, spouse2: charlotte)
    XCTAssert(charlotte.description == "[Person: firstName:Charlotte lastName:Neward age:45 job:nil spouse:Ted]")
    
    
    let familyIncome = family.householdIncome()
    XCTAssert(familyIncome == 1000)
    
    XCTAssert(family.description == "[Person: firstName:Ted lastName:Neward age:45 job:Gues Lecturer spouse:Charlotte], [Person: firstName:Charlotte lastName:Neward age:45 job:nil spouse:Ted], ")
  }
  
  func testFamilyWithKids() {
    let ted = Person(firstName: "Ted", lastName: "Neward", age: 45)
    ted.job = Job(title: "Gues Lecturer", type: Job.JobType.Salary(1000))
    
    let charlotte = Person(firstName: "Charlotte", lastName: "Neward", age: 45)
    
    let family = Family(spouse1: ted, spouse2: charlotte)

    let mike = Person(firstName: "Mike", lastName: "Neward", age: 22)
    mike.job = Job(title: "Burger-Flipper", type: Job.JobType.Hourly(5.5))
    
    let matt = Person(firstName: "Matt", lastName: "Neward", age: 16)
    family.haveChild(mike)
    family.haveChild(matt)
    
    XCTAssert(family.description == "[Person: firstName:Ted lastName:Neward age:45 job:Gues Lecturer spouse:Charlotte], [Person: firstName:Charlotte lastName:Neward age:45 job:nil spouse:Ted], [Person: firstName:Mike lastName:Neward age:22 job:Burger-Flipper spouse:nil], [Person: firstName:Matt lastName:Neward age:16 job:nil spouse:nil], ")
    
    let familyIncome = family.householdIncome()
    XCTAssert(familyIncome == 12000)
  }
  
}