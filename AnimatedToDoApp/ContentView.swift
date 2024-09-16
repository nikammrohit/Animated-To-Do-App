//
//  ContentView.swift
//  AnimatedToDoApp
//
//  Created by Rohit Nikam on 9/9/24.
//

import SwiftUI

// Defines a method to dismiss the keyboard
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

//Defines rect which is below header
struct RoundedCornersShape: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

struct Task: Identifiable{
    let id = UUID() //unique id for each task
    var title: String //title of the task
    var isChecked: Bool //checks if task is checked
}


struct ContentView: View {
    
    @State private var tasks: [Task] = [] //array holds all tasks
    @State private var isSandwichChecked: Bool = true //if box is checked
    @State private var taskText: String = "" //holds text for new task input
    
    var body: some View {
        ZStack{
            Color(red: 26/255, green: 27/255, blue: 37/255)
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                ZStack{
                    //header image
                    Image("headerImage")
                        .resizable()
                        .scaledToFit()
                        .edgesIgnoringSafeArea(.all)
                    
                    //grey rect containing tasks
                    RoundedCornersShape (corners: [.topLeft, .topRight], radius: 20)
                        .fill(Color(red: 26/255, green: 27/255, blue: 37/255))
                        .frame(height: 260) // Adjust the height as needed
                        .offset(y: 260) // Move the rectangle lower by adjusting this value
                    
                    Button(action: {
                        isSandwichChecked.toggle()
                    }) {
                        Image(systemName: isSandwichChecked ? "line.3.horizontal.circle" : "line.3.horizontal.decrease.circle.fill")
                            .foregroundColor(.blue)
                            .font(.title)
                            .padding()
                            .offset(x:-165, y: -70)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                }
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
                
                //scrollable list of tasks
                ScrollView{
                    VStack{
                        ForEach($tasks) {$task in
                            HStack{
                                //checkmark button
                                Button(action: {
                                    withAnimation(.easeOut(duration: 0.5)) {
                                        toggleTask(task)
                                    }
                                }) {
                                    Image(systemName: task.isChecked ? "checkmark.square.fill" : "checkmark.square")
                                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                                        .font(.title2)
                                        .position(x: 20)
                                }
                                .buttonStyle(PlainButtonStyle())
                                
                                Spacer()
                                
                                TextField("Task", text: $task.title)
                                    .foregroundColor(.white)
                                    .strikethrough(task.isChecked, color: .white)
                                    .animation(.easeInOut, value: task.isChecked)
                                    .position(x: -45) //y:-25
                            }
                        }
                    }
                    .padding(10)
                }
                .offset(y:-65)
                
                Button(action: {
                    addNewTask()
                }) {
                    Image(systemName: "plus.viewfinder")
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        .font(.title)
                    
                }
            }
            
        }// Detect taps outside the text field to dismiss the keyboard
        .onTapGesture {
            UIApplication.shared.endEditing() // Dismisses the keyboard
        }
        .ignoresSafeArea(.keyboard)
    }

    
    // Function to toggle the task's check state and remove it if checked
    private func toggleTask(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            // Toggle the task's checked state
            tasks[index].isChecked.toggle()
            
            // If the task is now checked, remove it with animation
            if tasks[index].isChecked {
                // Animate the removal of the task
                withAnimation(.easeOut(duration: 0.5)) {
                    tasks.remove(at: index)
                }
            }
        }
    }

    
    // Function to add a new task
    private func addNewTask() {
        let newTask = Task(title: taskText, isChecked: false)
        tasks.append(newTask)
        taskText = ""
    }
    
}

#Preview {
    ContentView()
}
