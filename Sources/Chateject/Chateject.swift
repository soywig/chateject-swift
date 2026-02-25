//
//  Chateject.swift
//  Chateject
//
//  Created by soywig on 25/2/26.
//

import Foundation

class Chateject {
    var auth: TwitchAuth
    
    init(auth: TwitchAuth) {
        self.auth = auth
    }
    
    init (clientId: String, clientSecret: String) {
        self.auth = TwitchAuth(clientId: clientId, clientSecret: clientSecret)
    }
}
