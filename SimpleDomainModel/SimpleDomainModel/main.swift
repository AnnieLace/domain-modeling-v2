//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation

print("Hello, World!")

public func testMe() -> String {
  return "I have been tested"
}

public class TestMe {
  public func Please() -> String {
    return "I have been tested"
  }
}

public protocol CustomStringConvertible
{
    var description : String { get }
}

public protocol Mathematics
{
    func +(left: Money, right: Money) -> Money
    func -(left: Money, right: Money) -> Money
}

extension Double
{
    var USD: Money {return Money(amount : (Int)(self), currency : "USD")}
    var EUR: Money {return Money(amount : (Int)(self), currency : "EUR")}
    var GBP: Money {return Money(amount : (Int)(self), currency : "GBP")}
    var YEN: Money {return Money(amount : (Int)(self), currency : "YEN")}
}

public func +( left : Money, right : Money ) -> Money
{
    var mon = right
    if(left.currency != right.currency)
    {
        mon = right.convert(left.currency)
    }
    return Money(amount: left.amount + mon.amount, currency: left.currency)
}

public func -( left : Money, right : Money ) -> Money
{
    var mon = right
    if(left.currency != right.currency)
    {
        mon = right.convert(left.currency)
    }
    return Money(amount: left.amount - mon.amount, currency: left.currency)
}
////////////////////////////////////
// Money
//
public struct Money : CustomStringConvertible, Mathematics {
  public var amount : Int
  public var currency : String
  public var description : String {
        get { return "\(self.amount) \(self.currency)"}
  }
  
  public func convert(to: String) -> Money {
    switch self.currency
    {
        case "USD":
            switch to
            {
                case "GBP": return Money(amount: self.amount / 2, currency: "GBP")
                case "EUR": return Money(amount: (Int)((Double)(self.amount) * 1.5), currency: "EUR")
                case "CAN": return Money(amount: (Int)((Double)(self.amount) * 1.25), currency: "CAN")
                default: return Money(amount: 0, currency: "NA")
            }
        
        case "GBP":
            switch to
            {
                case "USD": return Money(amount: self.amount * 2, currency: "USD")
                case "EUR": return Money(amount: self.amount * 3, currency: "EUR")
                case "CAN": return Money(amount: (Int)((Double)(self.amount) * 2.5), currency: "CAN")
                default: return Money(amount: 0, currency: "NA")
            }
        case "EUR":
            switch to
            {
                case "GBP": return Money(amount: (Int)((Double)(self.amount) * (1.0 / 3.0)), currency: "GBP")
                case "USD": return Money(amount: (Int)((Double)(self.amount) * (2.0 / 3.0)), currency: "USD")
                case "CAN": return Money(amount: (Int)((Double)(self.amount) * 1.2), currency: "CAN")
                default: return Money(amount: 0, currency: "NA")
            }
        case "CAN":
            switch to
            {
                case "GBP": return Money(amount: (Int)((Double)(self.amount) * 0.4), currency: "GBP")
                case "EUR": return Money(amount: (Int)((Double)(self.amount) * 0.83), currency: "EUR")
                case "USD": return Money(amount: (Int)((Double)(self.amount) * 0.8), currency: "USD")
                default: return Money(amount: 0, currency: "NA")
            }
    default: return Money(amount: 0, currency: "NA")
    }
  }
  
  public func add(to: Money) -> Money {
    if(to.currency != self.currency)
    {
        let mon = self.convert(to.currency);
        return Money(amount: to.amount + mon.amount, currency: to.currency)
    }
    return Money(amount: self.amount + to.amount, currency: to.currency)
  }
    
  public func subtract(from: Money) -> Money {
    if(from.currency != self.currency)
    {
        let mon = self.convert(from.currency);
        return Money(amount: mon.amount - from.amount, currency: from.currency)
    }
    return Money(amount: self.amount - from.amount, currency: from.currency)  }
 }

////////////////////////////////////
// Job
//
public class Job : CustomStringConvertible {
    public var title : String
    public var salary : JobType
    public var description : String {
        get {
            switch(self.salary)
            {
                case .Hourly(let wage) : return "\(title): \(wage) per hour"
                case .Salary(let wage) : return "\(title): \(wage) per year"
            }
        }
    }
    
    public enum JobType {
        case Hourly(Double)
        case Salary(Int)
    }
  
    public init(title : String, type : JobType) {
        self.title = title
        self.salary = type
    }
  
    public func calculateIncome(hours: Int) -> Int {
        switch(self.salary)
        {
            case .Hourly(let wage): return (Int)((Double)(hours) * wage)
            case .Salary(let wage): return wage
        }
    }
  
    public func raise(amt : Double) {
        switch(self.salary)
        {
            case .Hourly(let wage): self.salary = JobType.Hourly(wage + amt)
            case .Salary(let wage): self.salary = JobType.Salary((Int)((Double)(wage) + amt))
        }
    }
}

////////////////////////////////////
// Person
//
public class Person : CustomStringConvertible{
  public var firstName : String = ""
  public var lastName : String = ""
  public var age : Int = 0
  public var description : String {
      get {
        if(self.job != nil && self.spouse != nil)
        {
            return "[Person: firstName:\(firstName) lastName:\(lastName) age:\(age) job:\(job!.title) spouse:\(spouse!.firstName)]"
        }
        else if(self.job != nil)
        {
            return "[Person: firstName:\(firstName) lastName:\(lastName) age:\(age) job:\(job!.title) spouse:\(spouse?.firstName)]"        }
        else if(self.spouse != nil)
        {
            return "[Person: firstName:\(firstName) lastName:\(lastName) age:\(age) job:\(job?.title) spouse:\(spouse!.firstName)]"        }
        else
        {
            return "[Person: firstName:\(firstName) lastName:\(lastName) age:\(age) job:\(job?.title) spouse:\(spouse?.firstName)]"
        }
      }
  }
  
  private var _job : Job? = nil
    private var _spouse : Person? = nil
  public var job : Job? {
    get {
        return _job
    }
    set(value) {
        if(self.age > 16)
        {
            _job = value!
        }
    }
  }
  
  public var spouse : Person? {
    get {
        return _spouse
    }
    set(value) {
        if(self.age > 18)
        {
            _spouse = value!
        }
    }
  }
  
  public init(firstName : String, lastName: String, age : Int) {
    self.firstName = firstName
    self.lastName = lastName
    self.age = age
    
  }
  
  public func toString() -> String {
    return "[Person: firstName:\(firstName) lastName:\(lastName) age:\(age) job:\(job) spouse:\(spouse)]"
  }
}

////////////////////////////////////
// Family
//
public class Family : CustomStringConvertible {
  private var members : [Person] = []
    public var description : String {
        get {
            var toReturn = ""
            for member in self.members
            {
                toReturn += "\(member.description), "
            }
            return toReturn
        }
    }
  
  public init(spouse1: Person, spouse2: Person) {
    if(spouse1.spouse == nil && spouse2.spouse == nil)
    {
        spouse1.spouse = spouse2
        spouse2.spouse = spouse1
        self.members.append(spouse1)
        self.members.append(spouse2)
    }
  }
  
  public func haveChild(child: Person) -> Bool {
    var canHaveChild = false;
    for member in self.members {
        if(member.age >= 21)
        {
            canHaveChild = true;
        }
    }
    if(canHaveChild)
    {
        self.members.append(child);
    }
    return canHaveChild;
  }
  
  public func householdIncome() -> Int {
    var income = 0
    for member in self.members
    {
        if(member.job != nil)
        {
            switch(member.job!.salary)
            {
                case .Hourly(let wage): income += (Int)(wage * 40 * 50)
                case .Salary(let wage): income += wage
            }
        }
    }
    return income;
  }
}





