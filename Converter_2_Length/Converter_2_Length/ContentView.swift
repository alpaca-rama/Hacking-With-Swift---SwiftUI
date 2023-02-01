//
//  ContentView.swift
//  Converter_2_Length
//
//  Created by Luca Capriati on 2022/08/04.
//

import SwiftUI

struct ContentView: View {
    @State private var measurement = ""
    @State private var inputUnit = 0
    @State private var outputUnit = 0
    
    @FocusState private var inputIsFocused: Bool
    
    let unitOptions = [UnitLength.millimeters,
                       UnitLength.centimeters,
                       UnitLength.inches,
                       UnitLength.feet,
                       UnitLength.yards,
                       UnitLength.meters,
                       UnitLength.kilometers,
                       UnitLength.miles]
    
    var conversionCalculation: Measurement<UnitLength> {
        let inputAmount = Measurement(value: Double(measurement) ?? 0, unit: unitOptions[inputUnit])
        let outputAmount = inputAmount.converted(to: unitOptions[outputUnit])
        
        return outputAmount
    }
    
    var formatter: MeasurementFormatter {
        let newFormat = MeasurementFormatter()
        newFormat.unitStyle = .long
        newFormat.unitOptions = .providedUnit
        
        return newFormat
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Input")) {
                    TextField("\(formatter.string(from: unitOptions[inputUnit]))", text: $measurement)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)
                }
                
                Picker("Input Unit", selection: $inputUnit) {
                    ForEach(0..<unitOptions.count) {
                        let formattedOutput = formatter.string(from: unitOptions[$0])
                        Text("\(formattedOutput.capitalized)")
                    }
                }
                
                Picker("Output Unit", selection: $outputUnit) {
                    ForEach(0..<unitOptions.count) {
                        let formattedOutput = formatter.string(from: unitOptions[$0])
                        Text("\(formattedOutput.capitalized)")
                    }
                }
                
                Section(header: Text("Output")) {
                    Text(formatter.string(from: conversionCalculation))
                }
            }
            .navigationBarTitle("Convert Lengths")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        inputIsFocused = false
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
