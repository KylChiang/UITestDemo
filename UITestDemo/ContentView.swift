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
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("User Name: \(info.member.userName)")
                Text("Email: \(info.member.email)")
                Text("ID: \(info.member.id)")
            }
            Spacer().frame(width: 100, height: 50)
            Button(action: {
                if let token = AccessToken.current, !token.isExpired {
                    self.getMemberInfo()
                } else {
                    self.loginFB()
                }
            }) {
                Text("Facebook Login")
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
                print("result: \(data)")
                self.info.member.userName = data["name"] as? String ?? ""
                self.info.member.email = data["email"] as? String ?? ""
                self.info.member.id = data["id"] as? String ?? ""
            }
        }
    }
}
