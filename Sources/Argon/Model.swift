//
//  Model.swift
//  
//
//  Created by Lincoln Anders on 12/20/21.
//

import Foundation
import SerializedSwift
import PluralKit

open class ARModel: Serializable, Identifiable {
	@Serialized("id") private var arid: Int?
	public var id: Int {
		get { arid ?? -1 }
		set { arid = newValue }
	}
    @Serialized public var createdAt: Date?
    @Serialized public var updatedAt: Date?
	
	public required init(){}
	
	public static var modelName: String {
		String(describing: self).lowercased().pluralized()
	}
	public static var modelNameID: String {
		":\(String(describing: self).lowercased())_id"
	}
}

extension Date {
    public var relative: String {
        RelativeDateTimeFormatter().localizedString(for: self, relativeTo: Date())
    }
}
