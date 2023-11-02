//  /*
//
//  Project: DragandDrop
//  File: ContentView.swift
//  Created by: Elaidzha Shchukin
//  Date: 01.11.2023
//
//  */

import SwiftUI
import Algorithms

struct ContentView: View {
    @State private var toDoTask: [String] = ["Black Coffee", "Claptone", "Loui Vegga", "Bedouin"]
    @State private var inProgressTask: [String] = []
    @State private var doneTask: [String] = []
    
    var body: some View {
        
        HStack(spacing: 10) {
            ListView(title: "To Do", tasks: toDoTask)
            ListView(title: "In Progress", tasks: inProgressTask)
                .dropDestination(for: String.self) { droppedTasks, location in
                    for task in droppedTasks {
                        toDoTask.removeAll { $0 == task }
                        doneTask.removeAll { $0 == task }
                    }
                    let totalTasks = isProgressTask + droppedTasks
                    inProgressTask = Array(totalTasks.uniqued())
                    return true
                }
            ListView(title: "Done", tasks: doneTask)
        }
        .padding()
    }
}

#Preview {
    ContentView()
        //.previewInterfaceOrientation(.landscapeRight)
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
                    .foregroundColor(.gray.opacity(0.5))
                
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(tasks, id: \.self) { task in
                        Text(task)
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color.black.opacity(0.5))
                            .cornerRadius(15)
                            .shadow(color: .black, radius: 1, x: 1, y: 1)
                            .draggable(task)
                    }
                }
            }
        }
    }
}
