//
//  ReachabilityTest.swift
//  ReachabilityTest
//
//  Created by Evgeny on 26.02.24.
//

import Foundation
import XCTest

@testable import PokemonList

class ReachabilityTests: XCTestCase {

    func testIsConnectedToNetwork() {
        XCTAssertTrue(Reachability.isConnectedToNetwork(), "Expected to be connected to network")
    }
}
