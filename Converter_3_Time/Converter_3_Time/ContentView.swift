//
//  ContentView.swift
//  Converter_3_Time
//
//  Created by Luca Capriati on 2022/08/04.
//

import SwiftUI

struct ContentView: View {
    @State private var inputUnit:Int = 1
    @State private var outputUnit:Int = 1
    @State private var inputNumber:Int = 1
    
    @FocusState private var inputNumberIsFocused: Bool

    let units = [1, 60, 3600, 86400]
    let unitsDisplay = [
        1 : "Seconds",
        60 : "Minutes",
        3600 : "Hours",
        86400 : "Days"
    ]

    var convertedNumber: Double {
        let converted = Double(inputNumber) * Double(inputUnit) / Double(outputUnit);
        
        return converted
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $inputNumber, format: .number)
                        .keyboardType(.numberPad)
                        .focused($inputNumberIsFocused)
                } header: {
                    Text("Number to Convert")
                }

                Section {
                    Picker("Input Units", selection: $inputUnit) {
                        ForEach(units, id: \.self) {
                            if let label = unitsDisplay[$0] {
                                Text(label)
                            }
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Convert From")
                }

                Section {
                    Picker("Input Units", selection: $outputUnit) {
                        ForEach(units, id: \.self) {
                            if let label = unitsDisplay[$0] {
                                Text(label)
                            }
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Convert To")
                }

                Section {
                    Text(convertedNumber, format: .number)
                } header: {
                    Text("Converted Number")
                }
            }
            .navigationTitle("Convert It!")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()

                    Button("Done") {
                        inputNumberIsFocused = false
                    }
                }
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
