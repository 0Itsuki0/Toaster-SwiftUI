//
//  ProvideToasterModifier.swift
//  ToasterDemo
//
//  Created by Itsuki on 2025/03/22.
//

import SwiftUI

extension View {
    public func provideToaster(animationDisabled: Bool = false) -> some View {
        self.modifier(ProvideToasterModifier(animationDisabled: animationDisabled))
    }
}

private struct ProvideToasterModifier: ViewModifier {
    @State private var manager: ToastManager

    func body(content: Content) -> some View {
        ZStack {
            content
            ToastWrapper()
        }
        .environment(\.addToast, AddToastAction(_manager: manager))
        .environment(\.removeToast, RemoveToastAction(_manager: manager))
        .environment(manager)
    }
}

extension ProvideToasterModifier {
    init(animationDisabled: Bool) {
        self.manager = ToastManager(animationDisabled: animationDisabled)
    }
}

