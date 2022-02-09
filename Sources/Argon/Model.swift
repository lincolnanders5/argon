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

open class ARModelObject: Serializable, ObservableObject, Identifiable {
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

public protocol Based { static var baseURL: String { get } }
public typealias ARModel = ARModelObject & Based

extension ARModelObject {
    public static func fetch<T: ARModel>(record: inout T?, id: Int? = nil) async -> T? {
        guard let id = record?.id ?? id else {
            Logger.arm.log.error("Attempted to fetch into \(String(describing: T.self)) without providing an ID")
            return nil
        }
        
        let r: T? = await WebCommunicator.sendRequest(url: "\(T.baseURL)/\(id).json", option: .get)
        Logger.arm.log.info("fetch<record>->T? Fetched record [\(r?.id ?? 0)] found")
        return r
    }
    public static func fetchInto<T: ARModel>(_ array: inout [T]?) async {
        array = await WebCommunicator.sendRequest(url: T.baseURL + ".json", option: .get)
        let n = array?.count ?? 0
        Logger.arm.log.info("fetchInto<array>->[T]? Finished, \(n) item(s) found")
    }
}

extension Date {
    public var relative: String {
        RelativeDateTimeFormatter().localizedString(for: self, relativeTo: Date())
    }
}
