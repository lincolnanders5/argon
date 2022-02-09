//
//  Model+Fluent.swift
//  
//
//  Created by Lincoln Anders on 12/20/21.
//

import Foundation
import Argon
import Fluent

extension ARModelObject: Model {
    public var id: Int? {
        get { arid }
        set(newValue) { arid = newValue }
    }
	public typealias IDValue = Int
	public static var schema: String { modelName }
}
