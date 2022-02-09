//
//  ComboLog.swift
//  
//
//  Created by Lincoln Anders on 2/9/22.
//

import Foundation
import Argon
import os.log

public extension Logger {
    static let s = ComboLog(category: "server")
}
