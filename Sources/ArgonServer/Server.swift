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
		self.routes = []
	}
	
	public func listen() {
		do {
			app = try Application(.detect())
			defer {
				app?.shutdown()
				print("Server process has finished.")
			}
			print("Server now listening...")
			
			dumpRoutes()
			try app?.run()
		} catch {
			print(error)
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
