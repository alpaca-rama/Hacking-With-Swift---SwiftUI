//
//  ExpenseItem.swift
//  Project-7-iExpense
//
//  Created by Luca Capriati on 2022/08/17.
//

import Foundation

struct ExpenseItem: Identifiable, Codable, Equatable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
