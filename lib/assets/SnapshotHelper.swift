//
//  SnapshotHelper.swift
//  Example
//
//  Created by Felix Krause on 10/8/15.
//  Copyright © 2015 Felix Krause. All rights reserved.
//

import Foundation
import XCTest

func setLanguage(app: XCUIApplication)
{
    let path = "/tmp/language.txt"
    
    do {
        let locale = try NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding) as String
        app.launchArguments = ["-AppleLanguages", "(\(locale))"]
    } catch {
        print("Couldn't detect/set language...")
    }
}

func snapshot(name: String, waitForLoadingIndicator: Bool = true)
{
    if (waitForLoadingIndicator)
    {
        waitForLoadingIndicatorToDisappear()
    }
    
    print("snapshot: \(name)") // more information about this, check out https://github.com/krausefx/snapshot

    let view = XCUIApplication()
    let start = view.coordinateWithNormalizedOffset(CGVectorMake(-30, -30))
    let finish = view.coordinateWithNormalizedOffset(CGVectorMake(-30, -31))
    start.pressForDuration(0, thenDragToCoordinate: finish)
}

func waitForLoadingIndicatorToDisappear()
{
    let query = XCUIApplication().statusBars.childrenMatchingType(.Other).elementBoundByIndex(1).childrenMatchingType(.Other)
    
    while (query.count > 4) {
        sleep(1)
        print("Number of Elements in Status Bar: \(query.count)... waiting for status bar to disappear")
    }
}