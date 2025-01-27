//
//  RadialLayout.swift
//  RioSwiftUIKit
//
//  Created by Rio on 2025/1/27.
//
import SwiftUI

struct RadialLayout: Layout {
    func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) -> CGSize {
        proposal.replacingUnspecifiedDimensions()
    }

    func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) {
        guard !subviews.isEmpty else { return }

        // 计算半径为可用区域的一半（使子视图位于边界）
        let radius = min(bounds.width, bounds.height) / 2.0

        // 计算子视图之间的角度
        let angle = (Angle.degrees(360.0) / Double(subviews.count)).radians

        // 获取子视图的最大尺寸
        let maxSubviewSize = subviews.map { subview -> CGSize in
            let size = subview.sizeThatFits(.unspecified)
            return size
        }.reduce(.zero) { currentMax, size in
            CGSize(
                width: max(currentMax.width, size.width),
                height: max(currentMax.height, size.height)
            )
        }

        // 考虑子视图尺寸的实际半径调整
        let adjustedRadius =
            radius - max(maxSubviewSize.width, maxSubviewSize.height) / 2

        for (index, subview) in subviews.enumerated() {
            // 计算位置
            var point = CGPoint(x: 0, y: -adjustedRadius)
                .applying(
                    CGAffineTransform(rotationAngle: Double(index) * angle)
                )

            // 移动到视图中心
            point.x += bounds.midX
            point.y += bounds.midY

            // 放置子视图
            subview.place(
                at: point,
                anchor: .center,
                proposal: .unspecified
            )
        }
    }
}

#Preview {
    RadialLayout {
        ForEach(0..<10,id:\.self) { i in
            Text("\(i)").background {
//                Color.random()
            }
        }
    }
    .frame(width: 300, height: 300)
    .border(.black)
}
