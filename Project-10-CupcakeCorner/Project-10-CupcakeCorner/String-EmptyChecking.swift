//
//  String-EmptyChecking.swift
//  Project-10-CupcakeCorner
//
//  Created by Luca Capriati on 2022/09/05.
//

import Foundation

//  Project 10 - Challange 1:
extension String {
    var isReallyEmpty: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
