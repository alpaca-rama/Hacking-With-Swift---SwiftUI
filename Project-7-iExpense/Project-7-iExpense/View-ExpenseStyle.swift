//
//  View-ExpenseStyle.swift
//  Project-7-iExpense
//
//  Created by Luca Capriati on 2022/08/22.
//

import Foundation
import SwiftUI

// Project 7 - Challange 2
extension View {
    func style(for item: ExpenseItem) -> some View {
        if item.amount < 10 {
            return self.font(.body)
        } else if item.amount < 100 {
            return self.font(.title3)
        } else {
            return self.font(.title)
        }
    }
}
