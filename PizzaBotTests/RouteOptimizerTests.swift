//
//  RouteOptimizerTests.swift
//  PizzaBotTests
//
//  Created by Julio Collado on 12/9/21.
//

import XCTest
@testable import PizzaBot

class RouteOptimizerTests: XCTestCase {
    var routerOptimizer: Optimizable!
    
    override func setUp() {
        routerOptimizer = RouteOptimizer()
    }
    
    override func tearDown() {
        routerOptimizer = nil
    }

    func tests_optimize_succeeded() {
        var route: [GridPoint] = [GridPoint(xPoint: 3, yPoint: 0), GridPoint(xPoint: 0, yPoint: 1), GridPoint(xPoint: 1, yPoint: 1)]
        
        //MARK: - Case1
        var optimizeRoute = routerOptimizer.optimize(route: route)
        var rawOptimizeRoute = "011130"
        XCTAssertEqual(optimizeRoute.plainDescription, rawOptimizeRoute)
        
        //MARK: - Case2
        route = [GridPoint(xPoint: 0, yPoint: 0),
                 GridPoint(xPoint: 1, yPoint: 3),
                 GridPoint(xPoint: 4, yPoint: 4),
                 GridPoint(xPoint: 4, yPoint: 2),
                 GridPoint(xPoint: 4, yPoint: 2),
                 GridPoint(xPoint: 0, yPoint: 1),
                 GridPoint(xPoint: 3, yPoint: 2),
                 GridPoint(xPoint: 2, yPoint: 3),
                 GridPoint(xPoint: 4, yPoint: 1)]
        
        optimizeRoute = routerOptimizer.optimize(route: route)
        rawOptimizeRoute = "000113233242424144"
        XCTAssertEqual(optimizeRoute.plainDescription, rawOptimizeRoute)
        
        //MARK: - Case3
        route = [GridPoint(xPoint: 3, yPoint: 3),
                 GridPoint(xPoint: 3, yPoint: 3),
                 GridPoint(xPoint: 0, yPoint: 3),
                 GridPoint(xPoint: 3, yPoint: 0),
                 GridPoint(xPoint: 0, yPoint: 0),
                 GridPoint(xPoint: 0, yPoint: 0)]
        
        optimizeRoute = routerOptimizer.optimize(route: route)
        rawOptimizeRoute = "000003333330"
        XCTAssertEqual(optimizeRoute.plainDescription, rawOptimizeRoute)
        
        //MARK: - Case4
        route = [GridPoint(xPoint: 4, yPoint: 4),
                 GridPoint(xPoint: 2, yPoint: 2),
                 GridPoint(xPoint: 3, yPoint: 3),
                 GridPoint(xPoint: 3, yPoint: 2),
                 GridPoint(xPoint: 2, yPoint: 3),
                 GridPoint(xPoint: 3, yPoint: 1),
                 GridPoint(xPoint: 3, yPoint: 1)]
        
        optimizeRoute = routerOptimizer.optimize(route: route)
        rawOptimizeRoute = "22323323443131"
        XCTAssertEqual(optimizeRoute.plainDescription, rawOptimizeRoute)
        
        //MARK: - Case5
        route = [GridPoint(xPoint: 0, yPoint: 0),
                 GridPoint(xPoint: 1, yPoint: 1),
                 GridPoint(xPoint: 0, yPoint: 0)]
        
        optimizeRoute = routerOptimizer.optimize(route: route)
        rawOptimizeRoute = "000011"
        XCTAssertEqual(optimizeRoute.plainDescription, rawOptimizeRoute)
        
        //MARK: - Case6
        route = [GridPoint(xPoint: 4, yPoint: 4),
                 GridPoint(xPoint: 4, yPoint: 4),
                 GridPoint(xPoint: 4, yPoint: 4)]
        
        optimizeRoute = routerOptimizer.optimize(route: route)
        rawOptimizeRoute = "444444"
        XCTAssertEqual(optimizeRoute.plainDescription, rawOptimizeRoute)
        
        //MARK: - Case7
        route = [GridPoint(xPoint: 5, yPoint: 4),
                 GridPoint(xPoint: 4, yPoint: 5),
                 GridPoint(xPoint: 1, yPoint: 5)]
        
        optimizeRoute = routerOptimizer.optimize(route: route)
        rawOptimizeRoute = "154554"
        XCTAssertEqual(optimizeRoute.plainDescription, rawOptimizeRoute)
    }

}
