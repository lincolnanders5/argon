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
