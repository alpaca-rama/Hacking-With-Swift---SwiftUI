//
//  ContentView.swift
//  Converter
//
//  Created by Luca Capriati on 2022/08/04.
//

import SwiftUI

struct ContentView: View {
    @State private var valueToConvert = 0.0
    @State private var baseUnit = "Fahrenheit"
    @State private var convertedUnit = "Fahrenheit"
    
    @FocusState private var amountIsFocused: Bool
    
    let baseUnits = ["Celcius", "Fahrenheit", "Kelvin"]
    let convertedUnits = ["Celcius", "Fahrenheit", "Kelvin"]
    
    var valueConverted: Double {
        let value = valueToConvert
        
        if baseUnit == "Celcius" && convertedUnit == "Celcius" {
            return value
        } else if baseUnit == "Celcius" && convertedUnit == "Fahrenheit" {
            return (value * (9 / 5)) + 32
        } else if baseUnit == "Celcius" && convertedUnit == "Kelvin" {
            return value + 273.15
        } else if baseUnit == "Fahrenheit" && convertedUnit == "Celcius" {
            return (value - 32) * (5 / 9)
        } else if baseUnit == "Fahrenheit" && convertedUnit == "Fahrenheit" {
            return value
        } else if baseUnit == "Fahrenheit" && convertedUnit == "Kelvin" {
            return ((5 / 9) * (value - 32)) + 273
        } else if baseUnit == "Kelvin" && convertedUnit == "Celcius" {
            return value - 273.15
        } else if baseUnit == "Kelvin" && convertedUnit == "Fahrenheit" {
            return (1.8 * (value - 273)) + 32
        } else if baseUnit == "Kelvin" && convertedUnit == "Kelvin" {
            return value
        }
        
        return value
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Value to convert", value: $valueToConvert, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                } header: {
                    Text("Enter the value to convert")
                }
                
                Section {
                    Picker("Base Unit", selection: $baseUnit) {
                        ForEach(baseUnits, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Base unit")
                }
                
                Section {
                    Picker("Converted Unit", selection: $convertedUnit) {
                        ForEach(convertedUnits, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Converted unit")
                }
                
                Section {
                    Text("\(valueConverted, specifier: "%.2f") \(convertedUnit)")
                } header: {
                    Text("Output")
                }
                
            }
            .navigationTitle("Convert Temperature")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
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
