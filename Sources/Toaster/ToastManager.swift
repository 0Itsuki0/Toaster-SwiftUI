//
//  ToastManager.swift
//  ToasterDemo
//
//  Created by Itsuki on 2025/03/20.
//

import SwiftUI

@MainActor
@Observable
internal final class ToastManager {
    
    private var toasts: [ToastConfig] = []
    
    var topToasts: [ToastConfig] { return toasts.filter({$0.style.placement == .top}) }
    var bottomToasts: [ToastConfig] { return toasts.filter({$0.style.placement == .bottom}) }

    private var animationDisabled: Bool
    var animation: Animation? {
        return animationDisabled ? nil : .linear(duration: 0.15)
    }
    
    init(animationDisabled: Bool) {
        self.animationDisabled = animationDisabled
    }
    
    
    func addToast(_ toast: ToastConfig) {
        withAnimation(animation,  {
            toasts.insert(toast, at: 0)
        })
    }
    
    func removeToast(_ id: ToastConfig.ID) {
        withAnimation(animation,  {
            toasts.removeAll(where: {$0.id == id})
        })
    }
    
    func removeAllToasts() {
        withAnimation(animation,  {
            toasts.removeAll()
        })
    }
    
    func toastLoaded(_ toast: ToastConfig) {
        guard let firstIndex = self.toasts.firstIndex(where: {$0.id == toast.id}) else { return }
        self.toasts[firstIndex].loaded = true
    }
}
