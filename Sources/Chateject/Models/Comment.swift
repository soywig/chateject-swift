//
//  Comment.swift
//  Chateject
//
//  Created by soywig on 25/2/26.
//

import Foundation

public struct Comment: Codable, Hashable {
    public var author: String?
    public var message: String?
    public var timestamp: Int
    public var userColor: String?
    public var userBadges: [String]?
    public var createdAt: String
}
