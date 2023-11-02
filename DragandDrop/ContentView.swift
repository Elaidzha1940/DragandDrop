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
    @State private var toDoTask: [String] = ["Black Coffee", "Claptone", "Loui Vegga", "Bedouin"]
    @State private var isProgressTask: [String] = []
    @State private var doneTask: [String] = []
    
    var body: some View {
        
        HStack(spacing: 10) {
            ListView(title: "To Do", tasks: toDoTask)
            ListView(title: "In Progress", tasks: isProgressTask)
            ListView(title: "Done", tasks: doneTask)
        }
        .padding()
    }
}

#Preview {
    ContentView()
        .previewInterfaceOrientation(.landscapeRight)
}

struct ListView: View {
    let title: String
    let tasks: [String]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 20, weight: .bold, design: .rounded))
            
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.secondary)
                
                VStack(alignment: .leading, spacing: 15) {
                    ForEach(tasks, id: \.self) { task in
                        Text(task)
                            .padding(10)
                            .background(Color.secondary)
                            .cornerRadius(15)
                            .shadow(radius: 1, x: 1, y: 1)
                            .draggable(task)
                    }
                }
            }
        }
    }
}
