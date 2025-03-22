//
//  ToastPlacement.swift
//  ToasterDemo
//
//  Created by Itsuki on 2025/03/22.
//


import SwiftUI

public enum ToastPlacement: Equatable {
    case top
    case bottom
    
    internal var viewAlignment: Alignment {
        return switch self {
        case .top:
            .top
        case .bottom:
            .bottom
        }
    }
    
    internal var stackAlignment: Alignment {
        return switch self {
        case .top:
            .bottom
        case .bottom:
            .top
        }
    }
    
    internal var transitionEdge: Edge {
        return switch self {
        case .bottom:
            .bottom
        case .top:
            .top
        }
    }
}
