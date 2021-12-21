//
//  RouteOptions.swift
//  
//
//  Created by Lincoln Anders on 12/20/21.
//

import Foundation

/*
 * GET			/photos				photos#index	display a list of all photos
 * GET			/photos/new			photos#new		return an HTML form for creating a new photo
 * POST			/photos				photos#create	create a new photo
 * GET			/photos/:id			photos#show		display a specific photo
 * GET			/photos/:id/edit	photos#edit		return an HTML form for editing a photo
 * PATCH/PUT	/photos/:id			photos#update	update a specific photo
 * DELETE		/photos/:id			photos#destroy	delete a specific photo
 */
public enum RouteOption: CaseIterable { case index, new, create, show, edit, update, delete }
public enum HTTPOption : CaseIterable { case get, post, patch, delete }
public struct RouteHTTPOption {
	var routeOption: RouteOption
	var httpOption:  HTTPOption
	
	public init(_ ro: RouteOption) {
		self.routeOption = ro
		self.httpOption  = RouteHTTPOption.httpOptionFor(routeOption: ro)
	}
	
	public static func httpOptionFor(routeOption: RouteOption) -> HTTPOption {
		switch (routeOption) {
		case .index, .new, .show, .edit: return .get
		case .create: return .post
		case .update: return .patch
		case .delete: return .delete
		}
	}
}
