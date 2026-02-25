//
//  DownloadFullLog.swift
//  Chateject
//
//  Created by soywig on 25/2/26.
//

import Foundation

extension Chateject {
    func downloadFullLog(streamId: String) async throws -> ChatLog {
        return ChatLog(
            meta: try await downloadStreamMetadata(streamId: streamId),
            comments: try await downloadChatComments(streamId: streamId)
        )
    }
}
