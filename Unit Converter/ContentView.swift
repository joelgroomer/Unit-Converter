//
//  ContentView.swift
//  Unit Converter
//
//  Created by Joel Groomer on 6/5/21.
//

import SwiftUI

struct ContentView: View {

    enum TempScales: String, CaseIterable {
        case Celcius
        case Fahrenheit
        case Kelvin
    }

    @State private var fromTempTxt = ""
    @State private var selectedFromScale = TempScales.Celcius
    @State private var selectedToScale = TempScales.Fahrenheit
    
    var absoluteZero: Bool {
        // checks to see if the temperature input by the user is at or
        // below absolute zero
        if selectedFromScale == .Celcius && fromTemp <= -273.15 {
            return true
        }
        
        if selectedFromScale == .Fahrenheit && fromTemp <= -459.67 {
            return true
        }
        
        if selectedFromScale == .Kelvin && fromTemp <= 0.0 {
            return true
        }
        
        return false
    }
    
    
    var fromTemp: Double {
        return Double(fromTempTxt) ?? 0.0
    }
    
    var convertedValue: Double {
        // converts the entered value (if valid) from to the new scale
        // will not return a number below absolute zero
        
        if selectedFromScale == .Celcius {
            if selectedToScale == .Fahrenheit {
                if absoluteZero {
                    return -459.67
                } else {
                    return (fromTemp * 9.0 / 5.0) + 32.0
                }
            } else if selectedToScale == .Kelvin {
                if absoluteZero {
                    return 0.0
                } else {
                    return fromTemp + 273.15
                }
            } else {
                if absoluteZero {
                    return -273.15
                } else {
                    return fromTemp
                }
            }
        }
        
        if selectedFromScale == .Fahrenheit {
            if selectedToScale == .Celcius {
                if absoluteZero {
                    return -273.15
                } else {
                    return (fromTemp - 32.0) * 5.0 / 9.0
                }
            } else if selectedToScale == .Kelvin {
                if absoluteZero {
                    return 0.0
                } else {
                    return ((fromTemp - 32.0) * 5.0 / 9.0) + 273.15
                }
            } else {
                if absoluteZero {
                    return -459.67
                } else {
                    return fromTemp
                }
            }
        }
        
        if selectedFromScale == .Kelvin {
            if selectedToScale == .Celcius {
                if absoluteZero {
                    return -273.15
                } else {
                    return fromTemp - 273.15
                }
            } else if selectedToScale == .Fahrenheit {
                if absoluteZero {
                    return -459.67
                } else {
                    return ((fromTemp - 273.15) * 9.0 / 5.0) + 32.0
                }
            } else {
                if absoluteZero {
                    return 0.0
                } else {
                    return fromTemp
                }
            }
        }
        
        return 0.0
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Enter a number of degrees to convert from")) {
                    TextField("0.0 Degrees", text: $fromTempTxt)
                        .keyboardType(.numbersAndPunctuation)
                    Picker("Select temperature scale", selection: $selectedFromScale) {
                        ForEach(TempScales.allCases, id: \.rawValue) { scale in
                            Text(scale.rawValue)
                                .tag(scale)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Select a temperature scale to convert to")) {
                    Text("Converted value: \(convertedValue)")
                    Picker("Select temperature scale", selection: $selectedToScale) {
                        ForEach(TempScales.allCases, id: \.rawValue) { scale in
                            Text(scale.rawValue)
                                .tag(scale)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Text(absoluteZero ? "You've hit absolute zero!" : "")
            }
            .navigationBarTitle("Temp Converter")
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
