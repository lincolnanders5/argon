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

open class ARServer {
	private var app: Application?
	private var routes: [ARRoute]
	
	public init(routes: [[ARRoute]]) {
		self.routes = routes.flatMap { $0 as [ARRoute] }
		
		app = try! Application(.detect())
		loadRoutes()
	}
	
	public func listen() {
		print("Server now listening...")
		do {
			defer { app?.shutdown() }
			try app?.run()
		} catch { print(error) }
	}
	
	private func loadRoutes() {
		guard let app = app else { return }
		routes.forEach { route in
			print(route.option, route.handeler(route.option))
			app.on(route.vaporOption, route.pathComponents(), use: route.handeler(route.option))
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
