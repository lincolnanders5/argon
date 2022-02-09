//
//  WebCommunicator.swift
//  
//
//  Created by Lincoln Anders on 2/2/22.
//

import Foundation

public final class WebCommunicator {
    static var session = URLSession.shared
    var baseURL: URL
    
    public init(_ baseURL: String) {
        self.baseURL = URL(string: baseURL)!
    }
    
    public static func sendRequest<T: Decodable>(url: String, option: HTTPOption) async -> T? {
        guard let urlMir = URL(string: url) else { return nil }
        var req = URLRequest(url: urlMir, cachePolicy: .reloadIgnoringLocalCacheData)
        req.httpMethod = option.rawValue
        req.setValue("application/json", forHTTPHeaderField: "Accept")
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.setValue("XMLHttpRequest", forHTTPHeaderField: "X-Requested-With")
        
        do {
            let (data, _) = try await session.data(from: urlMir)
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            print(error)
            return nil
        }
    }
    
    public static func request<T: ARModel>(format: RouteOption) async -> T? {
        return nil
    }
    public static func request<T: ARModel>(format: RouteOption) async -> [T]? {
        await WebCommunicator.sendRequest(url: "http://192.168.1.151:3000/notifications.json", option: .get)
    }
    
    public static func fetch<T: ARModel>(record: inout T?) async {
        record = await request(format: .show)
    }
    public static func fetch<T: ARModel>(array: inout [T]?) async {
        array = await request(format: .index)
    }
}
