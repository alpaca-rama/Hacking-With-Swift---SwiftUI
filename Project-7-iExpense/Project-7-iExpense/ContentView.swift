//
//  ContentView.swift
//  Project-7-iExpense
//
//  Created by Luca Capriati on 2022/08/17.
//
// Challanges:
// Project 7 - Challange 1: Use the user’s preferred currency, rather than always using US dollars.
// Project 7 - Challange 2: Modify the expense amounts in ContentView to contain some styling depending
//  on their value – expenses under $10 should have one style, expenses under $100 another,
//  and expenses over $100 a third style. What those styles are depend on you.
// Project 7 - Challange 3: For a bigger challenge, try splitting the expenses list into two sections:
//  one for personal expenses, and one for business expenses. This is tricky for a few reasons,
//  not least because it means being careful about how items are deleted!

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false

    var body: some View {
        NavigationView {
            List {
                ExpenseSection(title: "Business", expenses: expenses.businessItems, deleteItems: removeBusinessItems)
                ExpenseSection(title: "Personal", expenses: expenses.personaItems, deleteItems: removePersonalItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }

    func removeItems(at offsets: IndexSet, in inputArray: [ExpenseItem]) {
        var objectsToDelete = IndexSet()
        
        for offeset in offsets {
            let item = inputArray[offeset]
            
            if let index = expenses.items.firstIndex(of: item) {
                objectsToDelete.insert(index)
            }
        }
        
        expenses.items.remove(atOffsets: objectsToDelete)
    }
    
    func removePersonalItems(at offsets: IndexSet) {
        removeItems(at: offsets, in: expenses.personaItems)
    }
    
    func removeBusinessItems(at offsets: IndexSet) {
        removeItems(at: offsets, in: expenses.businessItems)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
