//
//  PermissionRequestView.swift
//  AIPhotoManager
//
//  Created by Rio on 2025/3/24.
//

import SwiftUI

public struct PermissionRequestView: View {
    let icon: String
    let title: String
    let message: String
    let buttonTitle: String
    let action: () -> Void
    public init(icon: String, title: String, message: String, buttonTitle: String, action: @escaping () -> Void) {
        self.icon = icon
        self.title = title
        self.message = message
        self.buttonTitle = buttonTitle
        self.action = action
    }
    
    public var body: some View {
        VStack(spacing: 20) {
            Image(systemName: icon)
                .font(.system(size: 50))
                .foregroundColor(.gray)
            
            Text(title)
                .font(.headline)
            
            Text(message)
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button(action: action) {
                HStack {
                    Image(systemName: "gear")
                    Text(buttonTitle)
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
        }
        .padding()
    }
}
