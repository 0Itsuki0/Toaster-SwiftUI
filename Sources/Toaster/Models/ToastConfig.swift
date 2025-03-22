//
//  ToastConfig.swift
//  ToasterDemo
//
//  Created by Itsuki on 2025/03/22.
//

import SwiftUI

public struct ToastConfig: Identifiable {
    public let id = UUID()
    
    internal var contents: ContentsType
    internal var style: ToastStyle = .init()
    internal var loadingConfig: LoadingConfig?

    // non-nil value for auto-disappearing toast
    internal var timeout: TimeInterval?
    internal var showCloseButton: Bool = true
    internal var onDismiss: (() -> Void)?
    
    // so that the same loading config is not executed twice
    internal var loaded: Bool = false
}
