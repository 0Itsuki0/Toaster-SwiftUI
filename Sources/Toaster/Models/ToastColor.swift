//
//  ToastColor.swift
//  ToasterDemo
//
//  Created by Itsuki on 2025/03/22.
//

import SwiftUI


public enum ToastColor: Equatable {
    case `default`
    case primary
    case secondary
    case success
    case warning
    case danger
    case custom(Color)
    
    internal var icon: Image {
        return switch self {
        case .default:
            Image(systemName: "exclamationmark.circle.fill")
        case .primary:
            Image(systemName: "exclamationmark.circle.fill")
        case .secondary:
            Image(systemName: "exclamationmark.circle.fill")
        case .success:
            Image(systemName: "checkmark.circle.fill")
        case .warning:
            Image(systemName: "exclamationmark.shield.fill")
        case .danger:
            Image(systemName: "exclamationmark.octagon.fill")
        case .custom(_):
            Image(systemName: "exclamationmark.circle.fill")
        }
    }
    
    internal var baseColor: Color {
        return switch self {
        case .primary:
            Color.blue
        case .secondary:
            Color.purple
        case .success:
            Color.green
        case .warning:
            Color.yellow
        case .danger:
            Color.red
        case .default:
            Color.gray
        case .custom(let color):
            color
        }
    }
}
