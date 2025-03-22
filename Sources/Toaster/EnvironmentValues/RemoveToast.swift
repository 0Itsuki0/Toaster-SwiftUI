//
//  RemoveToast.swift
//  ToasterDemo
//
//  Created by Itsuki on 2025/03/22.
//

import SwiftUI

extension EnvironmentValues {
    public internal(set) var removeToast: RemoveToastAction {
        get { self[RemoveToastKey.self] }
        set { self[RemoveToastKey.self] = newValue }
    }
}

private struct RemoveToastKey: EnvironmentKey {
    static let defaultValue: RemoveToastAction = .init()
}


@MainActor
@preconcurrency
public struct RemoveToastAction: Sendable {
    internal weak var _manager: ToastManager?
    private var manager: ToastManager {
        guard let _manager else {
            fatalError("provideToaster must be called on a parent view to use EnvironmentValues.removeToast.")
        }
        return _manager
    }
    
    public func callAsFunction(_ id: ToastConfig.ID) {
        manager.removeToast(id)
    }
    
    // remove all toasts
    public func callAsFunction() {
        manager.removeAllToasts()
    }
}
