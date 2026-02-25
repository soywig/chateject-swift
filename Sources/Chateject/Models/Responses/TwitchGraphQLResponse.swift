//
//  TwitchGraphQLResponse.swift
//  Chateject
//
//  Created by soywig on 25/2/26.
//


struct TwitchGraphQLResponse: Decodable {
    let data: DataContainer?
    let errors: [GraphQLError]?

    struct DataContainer: Decodable {
        let video: Video?
    }

    struct Video: Decodable {
        let comments: Comments
    }

    struct Comments: Decodable {
        let edges: [Edge]
        let pageInfo: PageInfo
    }

    struct Edge: Decodable {
        let cursor: String
        let node: Node
    }

    struct Node: Decodable {
        let commenter: Commenter?
        let message: Message
        let contentOffsetSeconds: Int
        let createdAt: String
    }

    struct Commenter: Decodable {
        let displayName: String?
    }

    struct Message: Decodable {
        let fragments: [Fragment]?
        let userColor: String?
        let userBadges: [Badge]?
    }

    struct Fragment: Decodable {
        let text: String?
    }

    struct Badge: Decodable {
        let setID: String
    }

    struct PageInfo: Decodable {
        let hasNextPage: Bool
    }

    struct GraphQLError: Decodable {
        let message: String
    }
}
