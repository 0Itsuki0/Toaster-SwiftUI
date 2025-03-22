//
//  Toast.swift
//  ToasterDemo
//
//  Created by Itsuki on 2025/03/22.
//


import SwiftUI

extension Toast {
    init(toast: ToastConfig, isPlaceHolder: Bool) {
        self.toast = toast
        self.isPlaceHolder = isPlaceHolder
        self.loading = toast.loadingConfig != nil && !toast.loaded
    }
}


internal struct Toast: View {
    
    var toast: ToastConfig
    var isPlaceHolder: Bool
    
    @Environment(ToastManager.self) private var toastManager
    @Environment(\.colorScheme) private var colorScheme

    @State private var loading: Bool
    
    
    var body: some View {
        let style = toast.style

        HStack(spacing: 16) {
            switch toast.contents {
            case .builtIn(let builtInContents):
                if builtInContents.showIcon {
                    Group {
                        if loading {
                            ProgressView()
                                .progressViewStyle(.circular)
                                .tint(iconColor(style))
                            
                        } else {
                            if let icon = builtInContents.customIcon {
                                icon
                                    .resizable()
                                    .scaledToFit()
                                
                            } else {
                                toast.style.color.icon
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundStyle(iconColor(style))
                            }
                        }
                    }
                    .frame(width: 16, height: 16)

                }
                
                VStack(alignment: .leading, spacing: 0) {
                    let (title, message) = if loading, let loadingConfig = toast.loadingConfig {
                        (loadingConfig.title, loadingConfig.message)
                    } else {
                        (builtInContents.title, builtInContents.message)
                    }
                    
                    Text(isPlaceHolder ? "" : title)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                        .foregroundStyle(titleColor(style))
                
                    
                    if let message {
                        Text(isPlaceHolder ? "" : message)
                            .multilineTextAlignment(.leading)
                            .foregroundStyle(messageColor(style))
                    }

                }
            case .custom(let view):
                if !isPlaceHolder {
                    view
                }
            }
            
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .frame(minWidth: 240, alignment: isCustomContent() ? .center : .leading)
        .frame(minHeight: 48)
        
        .background(
            GeometryReader { proxy in
                RoundedRectangle(cornerRadius: cornerRadius(style, size: proxy.size))
                    .fill(colorScheme == .dark ? .black : .white)
                    .fill(backgroundColor(style))
                    .stroke(borderColor(style), style: .init(lineWidth: 1))
                    .shadow(color: .white.opacity(0.2), radius: 8, x: 0, y: 1)
            }
        )
        .overlay(alignment: .topTrailing, content: {
            if !isPlaceHolder && toast.showCloseButton {
                Button(action: {
                    removeToast()
                }, label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 12))
                        .foregroundStyle(style.color.baseColor.opacity(0.8))
                })
                .buttonStyle(.plain)
                .padding(.all, 4)
                .background(
                    Circle()
                        .fill(colorScheme == .dark ? .black : .white)
                        .fill(style.color.baseColor.opacity(0.3))
                        .stroke(style.color.baseColor.opacity(0.8), style: .init(lineWidth: 1))
                )
                .offset(x: style.radius == .full ?  4 : 8, y: style.radius == .full ?  -4 : -8)

            }
            
        })
        .transition(.asymmetric(insertion: .move(edge: style.placement.transitionEdge), removal: .identity))
        .task {
            if toast.loaded { return }
            toastManager.toastLoaded(toast)
            if let timeout = toast.timeout {
                DispatchQueue.main.asyncAfter(deadline: .now() + timeout) {
                    removeToast()
                }
            }
            await toast.loadingConfig?.promise()
            self.loading = false
        }

    }
    
    private func isCustomContent() -> Bool {
        return switch toast.contents {
        case .builtIn(_):
            false
        case .custom(_):
            true
        }
    }
    
    private func removeToast() {
        toast.onDismiss?()
        toastManager.removeToast(toast.id)
    }

    private func messageColor(_ style: ToastStyle) -> Color {
        style.variant == .solid ? colorScheme == .dark ? .white : .black : style.color.baseColor
    }
    
    private func iconColor(_ style: ToastStyle) -> Color {
        style.variant == .solid ?  colorScheme == .dark ? .white : .black : style.color.baseColor.opacity(0.8)
    }
    
    private func titleColor(_ style: ToastStyle) -> Color {
        style.variant == .solid ? colorScheme == .dark ? .white : .black : style.color.baseColor
    }
    
    private func backgroundColor(_ style: ToastStyle) -> Color {
        style.variant == .solid ? style.color.baseColor.opacity(0.3) : colorScheme == .dark ? .black.opacity(0.95) : .white.opacity(0.95)
    }

    
    private func borderColor(_ style: ToastStyle) -> Color {
        style.color.baseColor
    }
    
    private func cornerRadius(_ style: ToastStyle, size: CGSize) -> CGFloat {
        let height = size.height
        return switch style.radius {
        case .full:
            height/2
        default:
            style.radius.cornerRadius
        }
    }

}
