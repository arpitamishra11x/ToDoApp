//
//  ContentView.swift
//  ToDoApp
//
//  Created by students on 15/12/25.
//

import SwiftUI
import SwiftData

struct Notes: View {
    
    //Crud perform
    @Environment(\.modelContext)
    private var modelContext
    @Query private var lists: [Listt]
    
    @State private var title: String = ""
    @State private var isAlertPresented: Bool = false
    
    var body: some View {
        NavigationStack{
            List {
                ForEach(lists){
                    list in
                    Text(list.title)
                        .foregroundColor(.red)
                        .padding(10)
                        .swipeActions{
                            Button("Delete",role:.destructive){
                                modelContext.delete(list)
                            }
                            
                        }
                        .background(Color.green)
                }
                .navigationTitle("To Do List:")
                .toolbar{
                    ToolbarItem(placement: .bottomBar){
                        Button{
                            isAlertPresented.toggle()
                        }label:{
                            Image(systemName:"plus.circle")
                                .imageScale(.large)
                                .font(.largeTitle)
                                .foregroundColor(.blue)
                                .padding()
                        }
                    }
                }
                .alert("Create a new list",isPresented: $isAlertPresented){
                    TextField("Enter a List",text: $title)
                    
                    Button(){
                        modelContext
                            .insert(Listt(title: title))
                        title = ""
                    }label:{
                        Text("Save")
                    }
                    .disabled(title.isEmpty)
                }
            }
            .overlay{
                if lists.isEmpty{
                    ContentUnavailableView("My lists are not available",systemImage:"plus.circle",description:Text("Tap the plus button to add your New list"))
                }
            }
        }
    }
}

    
#Preview("Demo preview"){
        let container = try!
        ModelContainer(
            for: Listt.self,configurations:ModelConfiguration(
                isStoredInMemoryOnly: true)
        )
        
        container.mainContext
            .insert(Listt(title:"Swift Coding Club"))
        
        container.mainContext
            .insert(Listt(title:"Swift UI "))
        
        container.mainContext
            .insert(Listt(title:"App Development "))
        return Notes()
            .modelContainer(container)
    }



#Preview("main preview"){
    Notes()
        .modelContainer(for:Listt.self, inMemory:true)
}
