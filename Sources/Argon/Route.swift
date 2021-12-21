public struct ARRoute {
	public var option: RouteOption
	public var levels: [ARModel.Type]
	
	public init(option: RouteOption, levels: [ARModel.Type]) {
		self.option = option
		self.levels = levels
	}
	
	public var isIndexed : Bool {
		option == .show || option == .update || option == .delete || option == .edit
	}
	
	public func pathComponents() -> [String] {
		let ids   = levels.map 		  { $0.modelNameID }
		let names = levels.compactMap { $0.modelName   }
		
		var parts = zip(names, ids).flatMap { [$0.0, $0.1] }
		if !isIndexed { parts.removeLast() }
		
		if option == .edit { parts.append("edit") }
		if option == .new  { parts.append("new")  }
		
		return parts
	}
}

// Object Route Generation
extension ARModel {
	public static func routes(_ options: RouteOption...) -> [ARRoute] {
		var opts: [RouteOption] = options
		if opts.isEmpty { opts.append(contentsOf: RouteOption.allCases) }
		return opts.map { ARRoute(option: $0, levels: [self.self]) }
	}
}
