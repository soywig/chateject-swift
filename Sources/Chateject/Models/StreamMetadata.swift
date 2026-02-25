//
//  StreamMetadata.swift
//  Chateject
//
//  Created by soywig on 25/2/26.
//

import Foundation

public struct StreamMetadata: Codable {
    public var id: String?
    public var title: String?
    public var streamer: String?
    public var date: String?
    public var length: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case streamer = "user_name"
        case date = "created_at"
        case length = "duration"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        streamer = try container.decodeIfPresent(String.self, forKey: .streamer)
        date = try container.decodeIfPresent(String.self, forKey: .date)
        if let durationString = try container.decodeIfPresent(String.self, forKey: .length) {
            length = StreamMetadata.parseDuration(durationString)
        } else {
            length = nil
        }
    }
    
    private static func parseDuration(_ str: String) -> Int {
        var totalSeconds = 0
        var value = ""
        for char in str {
            if char.isNumber {
                value.append(char)
            } else {
                if let intVal = Int(value) {
                    switch char {
                    case "h":
                        totalSeconds += intVal * 3600
                    case "m":
                        totalSeconds += intVal * 60
                    case "s":
                        totalSeconds += intVal
                    default:
                        break
                    }
                }
                value = ""
            }
        }
        return totalSeconds
    }
}
