//
//  ContentView.swift
//  AnimatedToDoApp
//
//  Created by Rohit Nikam on 9/9/24.
//

import SwiftUI

struct ContentView: View {
    
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
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
                HStack{
                    //checkmark button
                    Button(action: {
                        isChecked.toggle()
                    }) {
                        Image(systemName: isChecked ? "checkmark.square" : "checkmark.square.fill")
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                            .font(.title2)
                            .position(x: 40, y:-20)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    
                    Text(taskText.isEmpty ? "Task" : taskText)
                            .foregroundColor(.white)
                            .strikethrough(!isChecked, color: .white)
                            .animation(.easeInOut, value: isChecked)
                            .position(x: -35, y:-20)
                    
                    
                    TextField("Task", text: $taskText)
                        .foregroundColor(.white)
                        .position(x: -35, y:-20)
                        .opacity(0)
                    
                        
                }
                
                //
                
            }
            
        }
    }
}

#Preview {
    ContentView()
}
