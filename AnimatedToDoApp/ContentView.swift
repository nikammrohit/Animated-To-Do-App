//
//  ContentView.swift
//  AnimatedToDoApp
//
//  Created by Rohit Nikam on 9/9/24.
//

import SwiftUI

struct Task: Identifiable{
    let id = UUID()
    var title: String
    var isChecked: Bool
}

struct ContentView: View {
    
    @State private var tasks: [Task] = []
    @State private var isChecked: Bool = true
    @State private var taskText: String = ""
    
    
    var body: some View {
        ZStack{
            Color(red: 26/255, green: 27/255, blue: 37/255)
                .edgesIgnoringSafeArea(.all)
                
            VStack{
                //header image
               Image("headerImage")
                    .resizable()
                    .scaledToFit()
                    .edgesIgnoringSafeArea(.all)
                
                
                HStack{
                    //checkmark button
                    Button(action: {
                        isChecked.toggle()
                    }) {
                        Image(systemName: isChecked ? "checkmark.square" : "checkmark.square.fill")
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                            .font(.title2)
                            .position(x: 40, y:-25)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Spacer()
                    
                    TextField("Task", text: $taskText)
                        .foregroundColor(.white)
                        .strikethrough(!isChecked, color: .white)
                        .animation(.easeInOut, value: isChecked)
                        .position(x: -35, y:-25)
                    
                        
                }
                
                Button(action: {
                    addNewTask()
                }) {
                    Image(systemName: "plus.viewfinder")
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        .font(.title)
                        
                }
                
            }
            
        }
    }
    
    // Function to add a new task
    private func addNewTask() {
        guard !taskText.isEmpty else { return }  // Ensure the task is not empty
        let newTask = Task(title: taskText, isChecked: false)
        tasks.append(newTask)
        taskText = ""  // Clear the input field after adding
    }
    
}

#Preview {
    ContentView()
}
