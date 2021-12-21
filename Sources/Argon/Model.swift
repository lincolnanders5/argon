//
//  Model.swift
//  
//
//  Created by Lincoln Anders on 12/20/21.
//

import Foundation
import SerializedSwift
import PluralKit

open class ARModel: Serializable {
	@Serialized("id") private var arid: Int?
	public var id: Int? {
		get { arid }
		set { arid = newValue }
	}
	
	public required init(){}
	
	public static var modelName: String {
		String(describing: self).lowercased().pluralized()
	}
	public static var modelNameID: String {
		":\(String(describing: self).lowercased())_id"
	}
}
