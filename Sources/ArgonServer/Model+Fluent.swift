//
//  File.swift
//  
//
//  Created by Lincoln Anders on 12/20/21.
//

import Foundation
import Fluent
import Argon
import PluralKit

extension ARModel: Model {
	public typealias IDValue = Int
	public static var schema: String { ARModel.schemaName(for: self) }
	
	private static func schemaName(for type: AnyClass) -> String {
		let mirror = Mirror(reflecting: type)
		let superType = String(describing: mirror.subjectType)
		let cleaned = superType.replacingOccurrences(of: ".Type", with: "")
		return cleaned.lowercased().pluralized()
	}
}
