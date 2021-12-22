//
//  Model+Fluent.swift
//  
//
//  Created by Lincoln Anders on 12/20/21.
//

import Foundation
import Argon
import Fluent

extension ARModel: Model {
	public typealias IDValue = Int
	public static var schema: String { modelName }
}
