//
//  MemberInfo.swift
//  UITestDemo
//
//  Created by N2120008436 on 2020/7/20.
//  Copyright © 2020 KylChiang. All rights reserved.
//

import UIKit
import Combine

class MemberInfo: ObservableObject {
    @Published var member = Member()
}
