//
//  ViewExtension.swift
//  RioSwiftUIKit
//
//  Created by Rio on 2025/1/14.
//

import Foundation
import SwiftUI

extension View  {
    @inlinable
    public func reverseMask<Mask: View>(
        alignment: Alignment = .center,
        @ViewBuilder _ mask: () -> Mask
    ) -> some View {
        self.mask {
            self.overlay(alignment: alignment) {
                mask()
                    .blendMode(.destinationOut)
            }
        }
    }
}
