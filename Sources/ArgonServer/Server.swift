//
//  Server.swift
//  
//
//  Created by Lincoln Anders on 12/20/21.
//

import AppKit
import Foundation
import Argon
import Vapor
import Fluent
import os.log

open class ARServer {
	private var app: Application?
	private var routes: [ARRoute]
	
	public init(routes: [[ARRoute]]) {
		self.routes = routes.flatMap { $0 as [ARRoute] }
		
		app = try! Application(.detect())
		loadRoutes()
	}
	
	public func listen() {
        Logger.s.log.info("Server now listening...")
		do {
			defer {
                Logger.s.log.info("Server shutting down.")
                app?.shutdown()
            }
			try app?.run()
        } catch { Logger.s.log.error("error: \(error.localizedDescription)") }
	}
	
	private func loadRoutes() {
		guard let app = app else { return }
		routes.forEach { route in
            Logger.s.log.info("\(route.vaporOption.rawValue) -> \(String(describing: route.option)) \(route.pathComponents().joined(separator: "/"))")
			app.on(route.vaporOption,
				   route.pathComponents(),
                   use: route.handler(route.option))
		}
	}
	
	func dumpRoutes() {
		guard let app = app else { return }
		guard app.routes.all.isEmpty == false else { return print("No routes configured.") }
		app.routes.all.forEach { route in
			print("\(route.method.string)   \(route.path.string)")
		}
	}
	
	public func config(_ closure: (ARServer, Application?) -> Void) -> ARServer {
		closure(self, app)
		return self
	}
}
