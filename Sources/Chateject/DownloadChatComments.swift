//
//  DownloadChatComments.swift
//  Chateject
//
//  Created by soywig on 25/2/26.
//

import Foundation

extension Chateject {
    func downloadChatComments(
        streamId: String,
        startOffset: Int = 0
    ) async throws -> [Comment] {
        let endpoint = URL(string: "https://gql.twitch.tv/gql")!
        let clientId = "kd1unb4b3q4t58fwlpcbzcbnm76a8fp"
        var comments: [Comment] = []

        var cursor: String?
        var isFirst = true
        var counter = 0

        while true {

            let variables: GraphQLQuery.Variables

            if isFirst {
                variables = .init(
                    videoID: streamId,
                    contentOffsetSeconds: startOffset
                )
            } else {
                variables = .init(
                    videoID: streamId,
                    cursor: cursor
                )
            }

            let query = GraphQLQuery(
                operationName: "VideoCommentsByOffsetOrCursor",
                variables: variables,
                extensions: .init(
                    persistedQuery: .init(
                        version: 1,
                        sha256Hash: "b70a3591ff0f4e0313d126c6a1502d79a1c02baebb288227c582044aa76adf6a"
                    )
                )
            )

            var request = URLRequest(url: endpoint)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(clientId, forHTTPHeaderField: "Client-ID")
            request.httpBody = try JSONEncoder().encode(query)

            do {
                let (data, _) = try await URLSession.shared.data(for: request)
                let decoded = try JSONDecoder().decode(TwitchGraphQLResponse.self, from: data)

                if let errors = decoded.errors {
                    print("GraphQL error:", errors)
                    break
                }

                guard
                    let edges = decoded.data?.video?.comments.edges,
                    !edges.isEmpty
                else {
                    break
                }

                for edge in edges {
                    let node = edge.node

                    let messageText =
                        node.message.fragments?.first?.text ?? ""

                    comments.append(
                        Comment(
                            author: node.commenter?.displayName,
                            message: messageText,
                            timestamp: node.contentOffsetSeconds,
                            userColor: node.message.userColor,
                            userBadges: node.message.userBadges?.map { $0.setID },
                            createdAt: node.createdAt
                        )
                    )
                }

                let pageInfo = decoded.data!.video!.comments.pageInfo

                if !pageInfo.hasNextPage {
                    break
                }

                cursor = edges.last?.cursor
                isFirst = false
            } catch {
                print("Request failed:", error)
                break
            }

            counter += 1
        }

        return comments
    }
}




