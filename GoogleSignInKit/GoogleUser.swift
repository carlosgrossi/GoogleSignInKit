//
//  GoogleUser.swift
//  GoogleSignInKit
//
//  Created by Carlos Grossi on 24/01/17.
//  Copyright © 2017 Carlos Grossi. All rights reserved.
//

import Foundation
import GoogleSignIn

public struct GoogleUser {
    fileprivate var user:GIDGoogleUser
    
    fileprivate init(user:GIDGoogleUser) {
        self.user = user
    }
    
    static func googleUser(withUser user:GIDGoogleUser?) -> GoogleUser? {
        guard let user = user else { return nil }
        return GoogleUser(user: user)
    }
    
}

// MARK: - Authentication
extension GoogleUser {
    
    public func authentication() -> GIDAuthentication {
        return user.authentication
    }
    
    public func accessToken() -> String {
        return user.authentication.accessToken
    }
    
    public func idToken() -> String {
        return user.authentication.idToken
    }
    
    public func idTokenExpiration() -> Date {
        return user.authentication.idTokenExpirationDate
    }
    
    public func clientID() -> String {
        return user.authentication.clientID
    }
	
	public func email() -> String {
		return user.profile.email
	}
    
}
