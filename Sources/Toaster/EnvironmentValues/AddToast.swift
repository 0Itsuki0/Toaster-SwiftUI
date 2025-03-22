//
//  AddToast.swift
//  ToasterDemo
//
//  Created by Itsuki on 2025/03/22.
//

import SwiftUI

extension EnvironmentValues {
    public internal(set) var addToast: AddToastAction {
        get { self[AddToastKey.self] }
        set { self[AddToastKey.self] = newValue }
    }
}

private struct AddToastKey: EnvironmentKey {
     static let defaultValue: AddToastAction = .init()
}

@MainActor
@preconcurrency
public struct AddToastAction: Sendable {
    internal weak var _manager: ToastManager?
    private var manager: ToastManager {
        guard let _manager else {
            fatalError("ProvideToast must be called on a parent view to use EnvironmentValues.addToast.")
        }
        return _manager
    }
    
    // for built-in contents configs
    @discardableResult
    public func callAsFunction(
        title: String,
        message: String? = nil,
        customIcon: Image? = nil,
        showIcon: Bool = true,
        
        style: ToastStyle = .init(),
        loadingConfig: LoadingConfig? = nil,
        
        timeout: TimeInterval? = nil,
        showCloseButton: Bool = true,
        onDismiss: (() -> Void)? = nil
        
    ) -> ToastConfig.ID {
        let toast = ToastConfig(
            contents: .builtIn(.init(title: title, message: message, customIcon: customIcon, showIcon: showIcon)),
            style: style,
            loadingConfig: loadingConfig,
            timeout: timeout,
            showCloseButton: showCloseButton,
            onDismiss: onDismiss
        )
        manager.addToast(toast)
        return toast.id
    }
    

    // for custom view
    @discardableResult
    public func callAsFunction<V: View>(
        @ViewBuilder content: () -> V,
        
        style: ToastStyle = .init(),
        loadingConfig: LoadingConfig? = nil,
        
        timeout: TimeInterval? = nil,
        showCloseButton: Bool = true,
        onDismiss: (() -> Void)? = nil
        
    ) -> ToastConfig.ID {
        let toast = ToastConfig(
            contents: .custom(AnyView(content())),
            style: style,
            loadingConfig: loadingConfig,
            timeout: timeout,
            showCloseButton: showCloseButton,
            onDismiss: onDismiss
        )
        
        manager.addToast(toast)
        return toast.id
    }
    
}
