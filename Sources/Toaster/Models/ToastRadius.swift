//
//  ToastRadius.swift
//  ToasterDemo
//
//  Created by Itsuki on 2025/03/22.
//


import SwiftUI

public enum ToastRadius: Equatable {
    case none
    case small
    case medium
    case large
    case full
    case custom(CGFloat)
    
    internal var cornerRadius: CGFloat {
        return switch self {
        case .none, .full:
            0
        case .small:
            8
        case .medium:
            12
        case .large:
            16
        case .custom(let radius):
            radius
        }
    }
}
