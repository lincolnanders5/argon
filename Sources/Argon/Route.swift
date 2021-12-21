public struct ARRoute {
	var option: RouteOption
	var levels: [ARModel.Type]
	
	public init(option: RouteOption, levels: [ARModel.Type]) {
		self.option = option
		self.levels = levels
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
