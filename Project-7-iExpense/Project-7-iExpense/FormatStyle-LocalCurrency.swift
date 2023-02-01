//
//  FormatStyle-LocalCurrency.swift
//  Project-7-iExpense
//
//  Created by Luca Capriati on 2022/08/18.
//

import Foundation

// Project 7 - Challange 1
extension FormatStyle where Self == FloatingPointFormatStyle<Double>.Currency {
    static var localCurrency: Self {
        .currency(code: Locale.current.currencyCode ?? "USD" )
    }
}
