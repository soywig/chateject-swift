//
//  Chateject.swift
//  Chateject
//
//  Created by soywig on 25/2/26.
//

import Foundation

public class Chateject {
    var auth: TwitchAuth
    
    public init(auth: TwitchAuth) {
        self.auth = auth
    }
    
    public init(clientId: String, clientSecret: String) {
        self.auth = TwitchAuth(clientId: clientId, clientSecret: clientSecret)
    }
}
