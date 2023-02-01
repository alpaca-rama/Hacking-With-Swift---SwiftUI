//
//  ContentView.swift
//  Project-4-BetterRest
//
//  Created by Luca Capriati on 2022/08/10.
//
// Challanges:
// Project 4 - Challange 1: Replace each VStack in our form with a Section, where the text view is the title of the section.
//  Do you prefer this layout or the VStack layout? It’s your app – you choose!
// Project 4 - Challange 2: Replace the “Number of cups” stepper with a Picker showing the same range of values.
// Project 4 - Challange 3: Change the user interface so that it always shows their recommended bedtime using a nice and large font.
//  You should be able to remove the “Calculate” button entirely.

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1

    // removed due to Project 4 - Challange 1
//    @State private var alertTitle = ""
//    @State private var alertMessage = ""
//    @State private var showingAlert = false

    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    // Project 4 - Challange 3
    var sleepResults: String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)

            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60

            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))

            let sleepTime = wakeUp - prediction.actualSleep
            
            return "Your ideal bedtime is " + sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            return "There was an error."
        }
    }

    var body: some View {
        NavigationView {
            Form {
                // Project 4 - Challange 1
                Section("When do you want to wake up?") {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                
                // Project 4 - Challange 1
                Section("Desired amount of sleep") {
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                
                // Project 4 - Challange 1
                Section("Daily coffee intake") {
                    // Project 4 - Challange 2
                    Picker("Number of cups", selection: $coffeeAmount) {
                        ForEach(1..<21) {
                            Text(String($0))
                        }
                    }
                }
                
                Text(sleepResults)
                    .font(.title3)
            }
            .navigationTitle("BetterRest")
            // removed due to Project 4 - Challange 3
//            .toolbar {
//                Button("Calculate", action: calculateBedtime)
//            }
//            .alert(alertTitle, isPresented: $showingAlert) {
//                Button("OK") { }
//            } message: {
//                Text(alertMessage)
//            }
        }
    }

    // Removed due to Project 4 - Challange 3
//    func calculateBedtime() {
//        do {
//            let config = MLModelConfiguration()
//            let model = try SleepCalculator(configuration: config)
//
//            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
//            let hour = (components.hour ?? 0) * 60 * 60
//            let minute = (components.minute ?? 0) * 60
//
//            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
//
//            let sleepTime = wakeUp - prediction.actualSleep
//            alertTitle = "Your ideal bedtime is…"
//            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
//        } catch {
//            alertTitle = "Error"
//            alertMessage = "Sorry, there was a problem calculating your bedtime."
//        }
//
//        showingAlert = true
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
