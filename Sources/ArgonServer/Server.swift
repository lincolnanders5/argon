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

open class ARServer {
	private var app: Application?
	private var routes: [ARRoute]
	
	public init(routes: [[ARRoute]]) {
		self.routes = routes.flatMap { $0 as [ARRoute] }
	}
	
	public func listen() {
		do {
			app = try Application(.detect())
			defer {
				app?.shutdown()
				print("Server process has finished.")
			}
			print("Server now listening...")
			
			loadRoutes()
			
			dumpRoutes()
			try app?.run()
		} catch {
			print(error)
		}
	}
	
	private func loadRoutes() {
		guard let app = app else { return }
		routes.forEach { route in
			app.on(route.vaporOption, route.pathComponents(), use: route.handler)
		}
	}
	
	func dumpRoutes() {
		guard let app = app else { return }
		guard app.routes.all.isEmpty == false else { return print("No routes configured.") }
		app.routes.all.forEach { route in
			print("\(route.method.string)   \(route.path.string)")
		}
	}
}
