//
//  Model.swift
//  
//
//  Created by Lincoln Anders on 12/20/21.
//

import Foundation
import SerializedSwift
import PluralKit
import os.log

open class ARModel: Serializable, ObservableObject, Identifiable {
	@Serialized("id") private var arid: Int?
	public var id: Int {
		get { arid ?? -1 }
		set { arid = newValue }
	}
    @Serialized public var createdAt: Date?
    @Serialized public var updatedAt: Date?
    @Published public var updated: Bool = false
	
	public required init(){}
	
	public static var modelName: String {
		String(describing: self).lowercased().pluralized()
	}
	public static var modelNameID: String {
		":\(String(describing: self).lowercased())_id"
	}
}

extension ARModel {
    public static func fetch<T: ARModel>(record: inout T?, id: Int? = nil) async -> T? {
        let r: T? = await WebCommunicator.sendRequest(url: "http://192.168.1.151:3000/notifications/\(id).json", option: .get)
        Logger.arm.log.info("fetch<record>->T? Fetched record [\(r?.id ?? 0)] found")
        return r
    }
    public static func fetchInto<T: ARModel>(_ array: inout [T]?) async {
        let c = array?.count ?? 0
        Logger.arm.log.info("fetchInto<array>->[T]? Finished, \(c) items found")
        array = await WebCommunicator.sendRequest(url: "https://jsonplaceholder.typicode.com/posts", option: .get)
    }
}

extension Date {
    public var relative: String {
        RelativeDateTimeFormatter().localizedString(for: self, relativeTo: Date())
    }
}
