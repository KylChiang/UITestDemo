//
//  UITestDemoUITests.swift
//  UITestDemoUITests
//
//  Created by N2120008436 on 2020/7/19.
//  Copyright © 2020 KylChiang. All rights reserved.
//

import XCTest

class UITestDemoUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFBLogin() throws {
        // 1. tap login
        app.buttons["Facebook Login"].tap()
        // 2. tap alert
        let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")

        let allowBtn = springboard.buttons["Continue"]
        if allowBtn.waitForExistence(timeout: 10) {
            allowBtn.tap()
        }
        
        // 3. tap FB [繼續] to login
        let loginPage = app.webViews
        loginPage.buttons["繼續"].tap()
        
        sleep(5)    // wait for the web login page loading finish
        
        // 4. back to first page, and check ID label is not empty with title "ID:"
        let predicate = NSPredicate(format: "label CONTAINS %@", "ID:")
        let label = app.staticTexts.matching(predicate).firstMatch
        XCTAssert(label.label.count > 4)
        
        // 5. logout, idle
        app.buttons["Logout"].tap()
    }
}
