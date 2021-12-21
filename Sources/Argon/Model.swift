//
//  Model.swift
//  
//
//  Created by Lincoln Anders on 12/20/21.
//

import Foundation
import SerializedSwift

open class ARModel: Serializable {
	@Serialized var id: Int?
	
	public required init(){}
}

extension ARModel {
	public static func routes(_ options: RouteOption...) {
		var opts: [RouteOption] = options
		if opts.isEmpty { opts.append(contentsOf: RouteOption.allCases) }
	}
}
