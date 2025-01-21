//
//  onShake.swift
//  RioSwiftUIKit
//
//  Created by Rio on 2025/1/20.
//


struct onShake: ViewModifier {
    @State private var degress: CGFloat = 0
    var amplitude:CGFloat?
    var anchor:UnitPoint?
    var action:() -> Void
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(degress), anchor: anchor ?? .top)
            .onTapGesture {
                action()
                withAnimation(.easeIn(duration: 0.2)) {
                    degress = amplitude ?? 20
                }
                withAnimation(.easeOut(duration: 0.2).delay(0.2)) {
                    degress = -(amplitude ?? 20)
                }
                withAnimation(.easeInOut(duration: 0.2).delay(0.4)) {
                    degress = 0
                }
            }
    }
}