//
//  LoadingConfig.swift
//  ToasterDemo
//
//  Created by Itsuki on 2025/03/22.
//

import SwiftUI

public struct LoadingConfig {
    public var promise: () async -> Void
    public var title: String
    public var message: String?
    
    public init(promise: @escaping () async -> Void, title: String, message: String? = nil) {
        self.promise = promise
        self.title = title
        self.message = message
    }
}
