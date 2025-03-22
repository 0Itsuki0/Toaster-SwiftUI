//
//  ToastStyle.swift
//  ToasterDemo
//
//  Created by Itsuki on 2025/03/22.
//

import SwiftUI

public struct ToastStyle {
    public var placement: ToastPlacement
    public var color: ToastColor
    public var variant: ToastVariant
    public var radius: ToastRadius
    
    public init(placement: ToastPlacement = .top, color: ToastColor = .default, variant: ToastVariant = .solid, radius: ToastRadius = .small) {
        self.placement = placement
        self.color = color
        self.variant = variant
        self.radius = radius
    }
}
