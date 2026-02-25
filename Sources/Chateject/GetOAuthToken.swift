//
//  GetOAuthToken.swift
//  Chateject
//
//  Created by soywig on 25/2/26.
//

import Foundation

func getOAuthToken(auth: TwitchAuth) async throws -> String {
    let endpoint = URL(string: "https://id.twitch.tv/oauth2/token")!
    
    var request = URLRequest(url: endpoint)
    request.httpMethod = "POST"
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.httpBody = "client_id=\(auth.clientId)&client_secret=\(auth.clientSecret)&grant_type=client_credentials".data(using: .utf8)
    
    let data = try await URLSession.shared.data(for: request).0
    let response = try JSONDecoder().decode(OAuthResponse.self, from: data)
    
    return response.accessToken
}

