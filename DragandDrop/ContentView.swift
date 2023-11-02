//  /*
//
//  Project: DragandDrop
//  File: ContentView.swift
//  Created by: Elaidzha Shchukin
//  Date: 01.11.2023
//
//  */

import SwiftUI

struct ContentView: View {
    @State private var toDoTask: [String] = ["Black Coffee", "Claptone", "Loui Vegga", "Bedouin"],
    @State private var isProgressTask: [String] = [],
    @State private var doneTask: [String] = []
    
    var body: some View {
        
        VStack {
            HStack(spacing: 35) {
                
            }
        }
    }
}

#Preview {
    ContentView()
}

struct ListView: View {
    let title: String
    let tasks: [String]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 20, weight: .bold, design: .rounded))
            
            ZStack {
            
            }
        }
    }
}
