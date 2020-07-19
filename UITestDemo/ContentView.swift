//
//  ContentView.swift
//  UITestDemo
//
//  Created by N2120008436 on 2020/7/19.
//  Copyright © 2020 KylChiang. All rights reserved.
//
//  reference: https://www.youtube.com/watch?v=h_BqOtj_Fsk

import SwiftUI
import FBSDKLoginKit

struct ContentView: View {
    var body: some View {
        loginButton().frame(width: 100, height: 44)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct loginButton: UIViewRepresentable {
    
    func makeCoordinator() -> Coordinator {
        return loginButton.Coordinator()
    }
    
    func makeUIView(context: Context) -> FBLoginButton {
        let button = FBLoginButton()
        button.delegate = context.coordinator
        return button
    }
    
    func updateUIView(_ uiView: FBLoginButton, context: Context) {
        
    }
    
    class Coordinator: NSObject, LoginButtonDelegate {
        func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
            if error != nil {
                print("FB Login Delegate Error: \(error.debugDescription)")
                return
            }
            
            // Auth success
            let request = GraphRequest(graphPath: "me", parameters: ["fields": "email, name, picture.type(normal)"])
            request.start { (_, result, error) in
                if let data = result as? [String: Any] {
                    print("result: \(data)")
                }
            }
        }
        
        func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
            // @TODO: Auth logout
        }
    }
}
