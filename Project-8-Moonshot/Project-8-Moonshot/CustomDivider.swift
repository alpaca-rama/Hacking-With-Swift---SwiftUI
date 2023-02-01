//
//  CustomDivider.swift
//  Project-8-Moonshot
//
//  Created by Luca Capriati on 2022/08/24.
//

import SwiftUI

struct CustomDivider: View {
    var body: some View {
        // Project 8 - Challange 2
        Rectangle()
            .frame(height: 2)
            .foregroundColor(.lightBackground)
            .padding(.vertical)
    }
}

struct CustomDivider_Previews: PreviewProvider {
    static var previews: some View {
        CustomDivider()
    }
}
