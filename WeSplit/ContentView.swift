//
//  ContentView.swift
//  WeSplit
//
//  Created by Cat-Tuong Tu on 11/6/23.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 12
    @FocusState private var amountIsFocused : Bool
    
    let tipPercentages = 0...100
    var totalPerPerson : Double {
        // We add by two because numberOfPeople is off by 2.
        // i.e. When the UI shows '4 people' it really means 2 people
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    var totalAmount : Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let totalAmount = checkAmount + tipValue
        
        return totalAmount
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                
                Picker("Number of people", selection: $numberOfPeople) {
                    ForEach(2..<100) {
                        Text("\($0) people")
                    }
                }
            }
            
            Section {
                Text("How much do you want to tip?")
                Picker("Tip percentage", selection: $tipPercentage) {
                    ForEach(tipPercentages, id: \.self) {
                        Text($0, format: .percent)
                    }
                }
                .pickerStyle(.wheel)
            }
            
            Section {
                Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD") )
            } header: {
                Text("Amount per person")
            }
            
            Section {
                Text(totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD") )
            } header: {
                Text("Total amount")
            }
        }
        .navigationTitle("WeSplit")
        .toolbar {
            if amountIsFocused {
                Button("Done") {
                    amountIsFocused = false
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
