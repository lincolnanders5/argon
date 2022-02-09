//
//  File.swift
//  
//
//  Created by Lincoln Anders on 2/7/22.
//

import Foundation
public protocol ARConfig {
    static var routes: [[ARRoute]] { get }
    static var wc: WebCommunicator { get }
}
