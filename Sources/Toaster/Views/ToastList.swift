//
//  ToastList.swift
//  ToasterDemo
//
//  Created by Itsuki on 2025/03/22.
//


import SwiftUI

internal struct ToastList: View {
    var placement: ToastPlacement
    var toasts: [ToastConfig]
    var animation: Animation?
    
    @State private var expanded: Bool = false
    @Namespace private var namespace

    var body: some View {
        Group {
            let toasts = placement == .top ? toasts : toasts.reversed()

            if !expanded {
                ZStack(alignment: placement.stackAlignment) {
                    ForEach(toasts) { toast in
                        let placeHolder = index(toast) != 0
                        
                        Toast(toast: toast, isPlaceHolder: placeHolder)
                            .scaleEffect(x: scale(toast), y: scale(toast))
                            .offset(y: offset(toast))
                            .zIndex(zIndex(toast))
                            .matchedGeometryEffect(id: toast.id, in: namespace)
                    }

                }
                
            } else {
                
                VStack(spacing: 16) {
                    ForEach(toasts) { toast in
                        Toast(toast: toast, isPlaceHolder: false)
                            .matchedGeometryEffect(id: toast.id, in: namespace)

                    }
                }
                .frame(alignment: placement.viewAlignment)
            }
        }
        .onTapGesture {
            guard toasts.count > 1 else { return }
            withAnimation(animation, {
                expanded.toggle()
            })

        }
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: placement.viewAlignment)
    }
    
    private func scale(_ toast: ToastConfig) -> CGFloat {
        guard let index = index(toast) else { return 1 }
        return 1 - CGFloat(index) * 0.1
    }
    
    private func offset(_ toast: ToastConfig) -> CGFloat {
        guard let index = index(toast) else { return 0 }
        return placement == .top ? CGFloat(index) * 8 : -CGFloat(index) * 8
    }
    
    private func zIndex(_ toast: ToastConfig) -> CGFloat {
        guard let index = index(toast) else { return 0 }
        return CGFloat(toasts.count - index)
    }
    
    private func index(_ toast: ToastConfig) -> Int? {
        toasts.firstIndex(where: {$0.id == toast.id})
    }
}
