//
//  poc_navigationTests.swift
//  poc-navigationTests
//
//  Created by Marcos Felipe Souza Pinto on 01/11/22.
//

import XCTest
@testable import poc_navigation

class poc_navigationTests: XCTestCase {

    var locator: BasicServiceLocator!
        
    override func setUp() {
        self.locator = BasicServiceLocator()
    }
    
    override func tearDown() {
        self.locator = nil
    }
    
    func testService1() {
        locator?.addService(DatabaseImpl() as Database)
        let database: Database = locator.getService()!
        database.save(person: Person(name: "Marcos"))
        print(database)
    }
    
    func testTwoServices() {
        locator.addService(DatabaseImpl() as Database)
        locator.addService(FetcherImpl() as Fetcher)

        
        let manager = PeopleManager(locator: locator)
        manager.addPerson()
    }
    
    func testThreeServices() {
        locator.addService(DatabaseImpl() as Database)
        locator.addService(FetcherImpl() as Fetcher)

        
        let manager = PeopleManager(locator: locator)
        XCTAssertEqual(manager.person(), Person(name: "Marcos"))
    }
    
    func testFourServices() {
        locator.with {
            $0.addService(DatabaseImpl() as Database)
            $0.addService(FetcherImpl() as Fetcher)
        }
        let manager = PeopleManager(locator: locator)
        XCTAssertEqual(manager.person(), Person(name: "Marcos"))
    }

}

struct Person: Equatable {
    var name: String
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.name == rhs.name
    }
}

protocol Database {
  func save(person: Person)
}

final class DatabaseImpl: Database, ObservableObject {
    func save(person: Person) {
        print("Salvou a Pessoa \(person.name)")
    }
}

protocol Fetcher {
  func fetch() -> Person
}
final class FetcherImpl: Fetcher {
    func fetch() -> Person {
        Person(name: "Marcos")
    }
}

final class PeopleManager {
    private let database: Database
    private let fetcher: Fetcher
    
    init(database: Database = DatabaseImpl(), fetcher: Fetcher = FetcherImpl()) {
        self.database = database
        self.fetcher = fetcher
    }
    
    init(locator: ServiceLocator) {
        self.database = locator.getService()!
        self.fetcher = locator.getService()!
    }
    
    func person() -> Person {
        return fetcher.fetch()
    }
    
    func addPerson() {
        let person = Person(name: "Marcos Felipe Add")
        database.save(person: person)
    }
}
