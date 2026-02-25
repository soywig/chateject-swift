//
//  DownloadStreamMetadata.swift
//  Chateject
//
//  Created by soywig on 25/2/26.
//

import Foundation

extension Chateject {
    func downloadStreamMetadata(streamId: String) async throws -> StreamMetadata? {
        let oAuthToken = try await getOAuthToken(auth: self.auth)
        
        let endpoint = URL(string: "https://api.twitch.tv/helix/videos?id=\(streamId)")!
        
        var request = URLRequest(url: endpoint)
        request.httpMethod = "GET"
        request.setValue(auth.clientId, forHTTPHeaderField: "Client-Id")
        request.setValue("Bearer \(oAuthToken)", forHTTPHeaderField: "Authorization")
        
        let data = try! await URLSession.shared.data(for: request).0
        let response = try! JSONDecoder().decode(StreamMetadataResponse.self, from: data)
        
        return response.data.first
    }
}

