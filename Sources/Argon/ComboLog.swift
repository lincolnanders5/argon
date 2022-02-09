//
//  File.swift
//  
//
//  Created by Lincoln Anders on 2/8/22.
//

import Foundation
import os.log
import os.signpost

struct ComboLog {
    private static var subsystem = Bundle.main.bundleIdentifier!
    var log: Logger
    var signpost: OSLog
    var category: String
    
    init(category: String) {
        self.category = category
        log = Logger(subsystem: ComboLog.subsystem, category: category)
        signpost = OSLog(subsystem: ComboLog.subsystem, category: category + "-signpost")
    }
    
    func time(_ body: @escaping () async -> Void) {
        let signpostID = OSSignpostID(log: signpost)
        let idstr = String(describing: signpostID.rawValue)
        os_signpost(.begin, log: signpost, name: "Logger Timer",
                    "Timer %{public}s started...", idstr)
        log.info("Timer \(idstr) started...")
        Task.init { await body() }
        os_signpost(.end, log: signpost, name: "Logger Timer",
                    "Timer %{public}s finished.", idstr)
        log.info("Timer \(idstr) finished.")
    }
}

extension Logger {
    /// Logs the view cycles like viewDidLoad.
    static let viewCycle = ComboLog(category: "viewcycle")
    static let wc = ComboLog(category: "web-communicator")
    static let arm = ComboLog(category: "ar-model")
}
