//
//  Route+Vapor.swift
//  
//
//  Created by Lincoln Anders on 12/21/21.
//

import Foundation
import Argon
import Vapor

extension ARRoute {
	var vaporOption: Vapor.HTTPMethod {
		switch (self.option.toHTTPOption()) {
		case .get:    return .GET
		case .patch:  return .PATCH
		case .post:   return .POST
		case .delete: return .DELETE
		}
	}
	
	func handeler(_ option: RouteOption) -> (Request) throws -> String {
		guard let handeler = handelers[option] else { return defaultHandler }
		return handeler as (Request) -> String
	}
	
	func defaultHandler(req: (Request)) throws -> String {
		"Hello, World"
	}
	
	public func pathComponents() -> [PathComponent] {
		let strComps: [String] = self.pathComponents()
		return strComps.compactMap { PathComponent(stringLiteral: $0) }
	}
}
