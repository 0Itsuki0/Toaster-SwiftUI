//
//  ContentsType.swift
//  ToasterDemo
//
//  Created by Itsuki on 2025/03/22.
//

import SwiftUI

internal enum ContentsType {
    case builtIn(BuiltInContents)
    case custom(AnyView)
}

internal struct BuiltInContents {
    var title: String
    var message: String?
    var customIcon: Image?
    var showIcon: Bool = true
}
