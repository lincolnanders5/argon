//
//  Route+Vapor.swift
//  
//
//  Created by Lincoln Anders on 12/21/21.
//

import Foundation
import Argon
import Vapor

typealias AsyncRequestHandeler = (Request) async throws -> String

extension ARRoute {
	var vaporOption: Vapor.HTTPMethod {
		switch (self.option.toHTTPOption()) {
		case .get:    return .GET
		case .patch:  return .PATCH
		case .post:   return .POST
		case .delete: return .DELETE
		}
	}
	
	func handler(_ option: RouteOption) -> AsyncRequestHandeler {
		guard let handeler = handelers[option] else {
			switch (option) {
			case .index: return { req async throws in
				let all = try await levels[0].query(on: req.db).all()
				print(all)
				return "index2"
			}
			default: break
			}
			return defaultHandler()
		}
		return handeler as AsyncRequestHandeler
	}
	
	func defaultHandler() -> AsyncRequestHandeler {
		return { _ in "Hello, World" }
	}
	
	public func pathComponents() -> [PathComponent] {
		let strComps: [String] = self.pathComponents()
		return strComps.compactMap { PathComponent(stringLiteral: $0) }
	}
}
