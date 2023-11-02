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
import UniformTypeIdentifiers

struct ContentView: View {
    @State private var toDoTasks: [DeveloperTask] = [MockData.taskOne, MockData.taskTwo, MockData.taskThree, MockData.taskFour, MockData.taskFive]
    @State private var inProgressTask: [DeveloperTask] = []
    @State private var doneTask: [DeveloperTask] = []
    
    @State private var isToDoTargeted = false
    @State private var isInProgressTargeted = false
    @State private var isDoneTargeted = false
    
    var body: some View {
        
        HStack(spacing: 10) {
            ListView(title: "To Do", tasks: toDoTasks, isTargeted: isToDoTargeted)
                .dropDestination(for: DeveloperTask.self) { droppedTasks, location in
                    for task in droppedTasks {
                        inProgressTask.removeAll { $0.id == task.id }
                        doneTask.removeAll { $0.id == task.id }
                    }
                    let totalTasks = toDoTasks + droppedTasks
                    toDoTasks = Array(totalTasks.uniqued())
                    return true
                } isTargeted: { isTargeted in
                    isToDoTargeted = isTargeted
                }
            
            ListView(title: "In Progress", tasks: inProgressTask, isTargeted: isInProgressTargeted)
                .dropDestination(for: DeveloperTask.self) { droppedTasks, location in
                    for task in droppedTasks {
                        toDoTasks.removeAll { $0.id == task.id }
                        doneTask.removeAll { $0.id == task.id }
                    }
                    let totalTasks = inProgressTask + droppedTasks
                    inProgressTask = Array(totalTasks.uniqued())
                    return true
                } isTargeted: { isTargeted in
                    isInProgressTargeted = isTargeted
                }
    
            ListView(title: "Done", tasks: doneTask, isTargeted: isDoneTargeted)
            .dropDestination(for: DeveloperTask.self) { droppedTasks, location in
                    for task in droppedTasks {
                        toDoTasks.removeAll { $0.id == task.id }
                        inProgressTask.removeAll { $0.id == task.id }
                    }
                    let totalTasks = doneTask + droppedTasks
                    doneTask = Array(totalTasks.uniqued())
                    return true
                } isTargeted: { isTargeted in
                    isDoneTargeted = isTargeted
                }
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
    let tasks: [DeveloperTask]
    let isTargeted: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 20, weight: .bold, design: .rounded))
            
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(isTargeted ? Color.mint.opacity(0.5) : Color.gray.opacity(0.7))
                
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(tasks, id: \.id) { task in
                        Text(task.title)
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

struct DeveloperTask: Codable, Hashable, Transferable {
    let id: UUID
    let title: String
    let owner: String
    let note: String
    
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .developerTask)
    }
}

extension UTType {
    static let developerTask = UTType(exportedAs: "EliId.DragandDrop")
}

struct MockData {
    static let taskOne = DeveloperTask(id: UUID(),
                                       title: "Black Coffee",
                                       owner: "ElaidzhaShchukin",
                                       note: "Note")
    
    static let taskTwo = DeveloperTask(id: UUID(),
                                       title: "Loui Vega",
                                       owner: "ElaidzhaShchukin",
                                       note: "Note")
    
    static let taskThree = DeveloperTask(id: UUID(),
                                       title: "Bedouin",
                                       owner: "ElaidzhaShchukin",
                                       note: "Note")
    
    static let taskFour = DeveloperTask(id: UUID(),
                                       title: "Claptone",
                                       owner: "ElaidzhaShchukin",
                                       note: "Note")
    
    static let taskFive = DeveloperTask(id: UUID(),
                                       title: "Dunmore Brothers",
                                       owner: "ElaidzhaShchukin",
                                       note: "Note")
}
