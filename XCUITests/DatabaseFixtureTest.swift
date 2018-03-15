/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import XCTest

class DatabaseFixtureTest: BaseTestCase {
    func testDatabaseFixture() {
        let file = "testDatabaseFixture-browser.db"
        let arg = LaunchArguments.LoadDatabasePrefix + file
        app.terminate()
        restart(app, args: [LaunchArguments.SkipIntro, LaunchArguments.SkipWhatsNew, arg])

        // app will now start with prepopulated database
        navigator.browserPerformAction(.openBookMarksOption)
        let list = app.tables["Bookmarks List"].cells.count
        XCTAssertEqual(list, 1, "There should be an entry in the bookmarks list")
    }

    func testHistoryDatabaseFixture() {
        let file = "testHistoryDatabase700-browser.db"
        let arg = LaunchArguments.LoadDatabasePrefix + file
        app.terminate()
        restart(app, args: [LaunchArguments.SkipIntro, LaunchArguments.SkipWhatsNew, arg])

        // app will now start with prepopulated database
        navigator.goto(HomePanel_History)
        //History list has two cells that are for recently closed and synced devices that should not count as history items
        let historyList = app.tables["History List"].cells.count-2
        XCTAssertEqual(historyList, 100, "There should be an entry in the bookmarks list")
    }
}
