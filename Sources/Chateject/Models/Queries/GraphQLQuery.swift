//
//  GraphQLQuery.swift
//  Chateject
//
//  Created by soywig on 25/2/26.
//


struct GraphQLQuery: Encodable {
    let operationName: String
    let variables: Variables
    let extensions: Extensions

    struct Variables: Encodable {
        let videoID: String
        let contentOffsetSeconds: Int?
        let cursor: String?

        init(videoID: String,
             contentOffsetSeconds: Int? = nil,
             cursor: String? = nil) {
            self.videoID = videoID
            self.contentOffsetSeconds = contentOffsetSeconds
            self.cursor = cursor
        }
    }

    struct Extensions: Encodable {
        let persistedQuery: PersistedQuery

        struct PersistedQuery: Encodable {
            let version: Int
            let sha256Hash: String
        }
    }
}
