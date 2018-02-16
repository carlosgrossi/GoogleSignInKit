//
//  GoogleSignInController.swift
//  GoogleSignInKit
//
//  Created by Carlos Grossi on 24/01/17.
//  Copyright © 2017 Carlos Grossi. All rights reserved.
//

import Foundation
import GoogleSignIn

public protocol GoogleSignInControllerDelegate {
    func googleSignInController(_ controller:GoogleSignInController, signIn:GoogleSignIn?, didSignInFor user:GoogleUser?, withError error:Error?)
    func googleSignInController(_ controller:GoogleSignInController, didDisconnectUser user:GoogleUser?, withError error:Error?)
}

public protocol GoogleSignInControllerUIDelegate {
    func googleSignInController(_ controller:GoogleSignInController, signInWillDispatch signIn:GoogleSignIn?, withError error:Error?)
    func googleSignInController(_ controller:GoogleSignInController, signIn:GoogleSignIn?, present viewController:UIViewController)
    func googleSignInController(_ controller:GoogleSignInController, signIn:GoogleSignIn?, dismiss viewController:UIViewController)
}

public class GoogleSignInController: NSObject {
    public static let sharedSignIn = GoogleSignInController()
    
    public var delegate:GoogleSignInControllerDelegate?
    public var uiDelegate:GoogleSignInControllerUIDelegate?
    
    public var clientId:String? {
        get { return GIDSignIn.sharedInstance().clientID }
        set(newClientId) { GIDSignIn.sharedInstance().clientID = newClientId }
    }
    
    public override init() {
        super.init()
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    public convenience init(clientId:String?, delegate:GoogleSignInControllerDelegate? = nil, uiDelegate:GoogleSignInControllerUIDelegate? = nil) {
        self.init()
        self.clientId = clientId
        self.delegate = delegate
        self.uiDelegate = uiDelegate
    }
}

// MARK: - Sign In / Sign Out
extension GoogleSignInController {
    
    public func signIn() -> Void {
        GIDSignIn.sharedInstance().signIn()
    }
    
    public func signInSilently() -> Void {
        GIDSignIn.sharedInstance().signInSilently()
    }
    
    public func signOut() -> Void {
        GIDSignIn.sharedInstance().signOut()
    }
    
    public func disconnect() -> Void {
        GIDSignIn.sharedInstance().disconnect()
    }
    
    public func hasAuthInKeychain() -> Bool {
        return GIDSignIn.sharedInstance().hasAuthInKeychain()
    }
    
}

// MARK: - 
extension GoogleSignInController {
    
    public func handle(url:URL, sourceApplication:String?, annotation:Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
}

// MARK: -
extension GoogleSignInController {
    
    public func currentUser() -> GoogleUser? {
        return GoogleUser.googleUser(withUser: GIDSignIn.sharedInstance().currentUser)
    }
    
    public func setShouldFetchBasicProfile(shouldFetchBasicProfile:Bool) {
        GIDSignIn.sharedInstance().shouldFetchBasicProfile = shouldFetchBasicProfile
    }
    
    public func getShouldFetchBasicProfile() -> Bool {
        return GIDSignIn.sharedInstance().shouldFetchBasicProfile
    }
    
    public func setLanguage(laguage:String) {
        GIDSignIn.sharedInstance().language = laguage
    }
    
    public func getLanguage() -> String {
        return GIDSignIn.sharedInstance().language
    }
    
    public func setLoginHint(loginHint:String) {
        GIDSignIn.sharedInstance().loginHint = loginHint
    }
    
    public func getLoginHint() -> String {
        return GIDSignIn.sharedInstance().loginHint
    }
    
}

// MARK: - UI
extension GoogleSignInController {
    
    public func addGoogleSignInButton(asSubviewOfView view:UIView) -> UIView {
        let signInButton = GIDSignInButton(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        view.addSubview(signInButton)
        
        view.addConstraint(NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: signInButton, attribute: .leading, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: signInButton, attribute: .trailing, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: signInButton, attribute: .top, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: signInButton, attribute: .bottom, multiplier: 1, constant: 0))
        
        return view
    }
    
}

// MARK: - GIDSignInDelegate
extension GoogleSignInController: GIDSignInDelegate {
    
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        delegate?.googleSignInController(self, signIn: GoogleSignIn.googleSignIn(withSignIn: signIn), didSignInFor: GoogleUser.googleUser(withUser: user), withError: error)
    }
    
    public func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        delegate?.googleSignInController(self, didDisconnectUser: GoogleUser.googleUser(withUser: user), withError: error)
    }
    
}

// MARK: - GIDSignInUIDelegate
extension GoogleSignInController: GIDSignInUIDelegate {
    
    public func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        uiDelegate?.googleSignInController(self, signInWillDispatch: GoogleSignIn.googleSignIn(withSignIn: signIn), withError: error)
    }
    
    public func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        uiDelegate?.googleSignInController(self, signIn: GoogleSignIn.googleSignIn(withSignIn: signIn), present: viewController)
    }
    
    public func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        uiDelegate?.googleSignInController(self, signIn: GoogleSignIn.googleSignIn(withSignIn: signIn), dismiss: viewController)
    }
    
}
