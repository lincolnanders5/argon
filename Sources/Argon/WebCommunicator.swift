//
//  WebCommunicator.swift
//  
//
//  Created by Lincoln Anders on 2/2/22.
//

import Foundation
import os.log

public final class WebCommunicator {
    static var session = URLSession.shared
    var baseURL: URL
    
    public init(_ baseURL: String) {
        self.baseURL = URL(string: baseURL)!
    }
    
    public static func sendRequest<T: Decodable>(url: String, option: HTTPOption) async -> T? {
        Logger.wc.log.info("starting fetch to \(url) as type \(String(describing: T.self))")
        guard let urlMir = URL(string: url) else { return nil }
        var req = URLRequest(url: urlMir, cachePolicy: .reloadIgnoringLocalCacheData)
        req.httpMethod = option.rawValue
        req.setValue("application/json", forHTTPHeaderField: "Accept")
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.setValue("XMLHttpRequest", forHTTPHeaderField: "X-Requested-With")
        
        do {
            let (data, _) = try await session.data(from: urlMir)
            let decoder = JSONDecoder()
            let res = try decoder.decode(T.self, from: data)
            Logger.wc.log.info("fetched from \(url)")
            return res
        } catch {
            print(error)
            return nil
        }
    }
}

