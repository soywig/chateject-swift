//
//  ChatLog.swift
//  Chateject
//
//  Created by soywig on 25/2/26.
//

import Foundation

public struct ChatLog: Codable {
    public var meta: StreamMetadata?
    public var comments: [Comment]?
    
    public init(meta: StreamMetadata? = nil, comments: [Comment]? = nil) {
        self.meta = meta
        self.comments = comments
    }
}
