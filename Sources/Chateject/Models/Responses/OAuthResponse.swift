//
//  OAuthResponse.swift
//  Chateject
//
//  Created by soywig on 25/2/26.
//


struct OAuthResponse: Codable {
    let accessToken: String
    let expiresIn: Int
    let tokenType: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case expiresIn = "expires_in"
        case tokenType = "token_type"
    }
}
