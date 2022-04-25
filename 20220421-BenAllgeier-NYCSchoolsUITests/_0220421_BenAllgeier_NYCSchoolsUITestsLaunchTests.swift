//
//  _0220421_BenAllgeier_NYCSchoolsUITestsLaunchTests.swift
//  20220421-BenAllgeier-NYCSchoolsUITests
//
//  Created by Benjamin Allgeier on 4/21/22.
//

import XCTest

class _0220421_BenAllgeier_NYCSchoolsUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
