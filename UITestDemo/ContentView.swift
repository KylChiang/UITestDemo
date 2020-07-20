//
//  ContentView.swift
//  UITestDemo
//
//  Created by N2120008436 on 2020/7/19.
//  Copyright © 2020 KylChiang. All rights reserved.
//

import SwiftUI
import FBSDKLoginKit

struct ContentView: View {
    @EnvironmentObject var info: MemberInfo
    @State var isLogining: Bool = false
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("User Name: \(info.member.userName)")
                Text("Email: \(info.member.email)")
                Text("ID: \(info.member.id)")
            }
            Spacer().frame(width: 100, height: 50)
            
            if isLogining == false {
                Button(action: {
                    if let token = AccessToken.current, !token.isExpired {
                        self.getMemberInfo()
                    } else {
                        self.loginFB()
                    }
                }) {
                    Text("Facebook Login")
                }
            } else {
                Button(action: {
                    self.logoutFB()
                }) {
                    Text("Logout")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(MemberInfo())
    }
}

extension ContentView {
    func loginFB() {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile", "email"], from: nil) { (result, error) in
            self.getMemberInfo()
        }
    }
    
    func getMemberInfo() {
        let request = GraphRequest(graphPath: "me", parameters: ["fields": "email, name, picture.type(normal)"])
        request.start { (_, result, error) in
            if let data = result as? [String: Any] {
                self.info.member = Member(userName: data["name"] as? String ?? "",
                                          email: data["email"] as? String ?? "",
                                          id: data["id"] as? String ?? "")
                self.isLogining = true
            }
        }
    }
    
    func logoutFB() {
        LoginManager().logOut()
        info.member = Member()
        isLogining = false
    }
}
