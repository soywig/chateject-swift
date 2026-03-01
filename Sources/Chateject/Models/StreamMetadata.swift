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
    
    enum TwitchCodingKeys: String, CodingKey {
        case id
        case title
        case streamer = "user_name"
        case date = "created_at"
        case length = "duration"
    }
    
    enum OwnCodingKeys: String, CodingKey {
        case id, title, streamer, date, length
    }
    
    public init(from decoder: Decoder) throws {
        let twitchContainer = try decoder.container(keyedBy: TwitchCodingKeys.self)
        let ownContainer = try decoder.container(keyedBy: OwnCodingKeys.self)
        id = try twitchContainer.decodeIfPresent(String.self, forKey: .id)
        title = try twitchContainer.decodeIfPresent(String.self, forKey: .title)
        streamer = (try? twitchContainer.decodeIfPresent(String.self, forKey: .streamer)) ?? (try? ownContainer.decodeIfPresent(String.self, forKey: .streamer))
        date = (try? twitchContainer.decodeIfPresent(String.self, forKey: .date)) ?? (try? ownContainer.decodeIfPresent(String.self, forKey: .date))
        if let durationString =
            (try? twitchContainer.decodeIfPresent(String.self, forKey: .length))
            ?? (try? ownContainer.decodeIfPresent(String.self, forKey: .length))
        {
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
