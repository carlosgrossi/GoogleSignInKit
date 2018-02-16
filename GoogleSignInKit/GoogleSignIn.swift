//
//  GoogleSignIn.swift
//  GoogleSignInKit
//
//  Created by Carlos Grossi on 24/01/17.
//  Copyright © 2017 Carlos Grossi. All rights reserved.
//

import Foundation
import GoogleSignIn

public struct GoogleSignIn {
    fileprivate var signIn:GIDSignIn
    
    fileprivate init(signIn:GIDSignIn) {
        self.signIn = signIn
    }
    
    static func googleSignIn(withSignIn signIn:GIDSignIn?) -> GoogleSignIn? {
        guard let signIn = signIn else { return nil }
        return GoogleSignIn(signIn: signIn)
    }
    
}
