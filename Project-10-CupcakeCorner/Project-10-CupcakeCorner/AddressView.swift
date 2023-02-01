//
//  AddressView.swift
//  Project-10-CupcakeCorner
//
//  Created by Luca Capriati on 2022/08/31.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: SharedOrder
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                TextField("Street address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
            }
            
            Section {
                NavigationLink {
                    CheckoutVIew(order: order)
                } label: {
                    Text("Checkout")
                }
            }
            .disabled(order.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AddressView(order: SharedOrder())
        }
    }
}
