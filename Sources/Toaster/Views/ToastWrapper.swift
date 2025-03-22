//
//  ToastWrapper.swift
//  ToasterDemo
//
//  Created by Itsuki on 2025/03/22.
//

import SwiftUI

internal struct ToastWrapper: View {
    @Environment(ToastManager.self) private var toastManager
    @Environment(\.safeAreaInsets) private var safeAreaInsets

    var body: some View {
        ZStack {
            ToastList(placement: .top, toasts: Array(toastManager.topToasts.prefix(3)), animation: toastManager.animation)
            ToastList(placement: .bottom, toasts: Array(toastManager.bottomToasts.prefix(3)), animation: toastManager.animation)
        }
        .frame(width: UIScreen.main.bounds.width - safeAreaInsets.leading - safeAreaInsets.trailing, height: UIScreen.main.bounds.height - safeAreaInsets.top - safeAreaInsets.bottom)

    }
}
