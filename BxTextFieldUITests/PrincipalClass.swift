//
//  PrincipalClass.swift
//  LeakmaxUITests
//
//  Created by Ondrej Macoszek on 08/02/2019.
//  Copyright © 2019 com.showmax. All rights reserved.
//

import Foundation
import XCTest

class PrincipalClass: NSObject, XCTestObservation {
    override init() {
        super.init()
        XCTestObservationCenter.shared.addTestObserver(self)
    }
}
