//
//  CheckoutVIew.swift
//  Project-10-CupcakeCorner
//
//  Created by Luca Capriati on 2022/08/31.
//

import SwiftUI

struct CheckoutVIew: View {
    @ObservedObject var order: SharedOrder
    @State private var confirmationMessage = ""
    @State private var showConfirmationMessage = false
    
    //  Project 10 - Challange 2:
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                    .padding()
            }
        }
        .navigationTitle("Checkout")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Thank you!", isPresented: $showConfirmationMessage) {
            Button("OK") { }
        } message: {
            Text(confirmationMessage)
        }
        .alert("Oops!", isPresented: $showingError) {
            Button("OK") { }
        } message: {
            Text(errorMessage)
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order.data) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(SharedOrder.types[decodedOrder.type].lowercased()) cupcakes is on its way"
            showConfirmationMessage = true
        } catch {
            //  Project 10 - Challange 2:
            errorMessage = "Sorry, checkout failed.\n\nMessage: \(error.localizedDescription)"
            showingError = true
        }
    }
}

struct CheckoutVIew_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CheckoutVIew(order: SharedOrder())
        }
    }
}
