import SwiftUI

struct TodoListViewFeature: View {
    @ObservedObject
    var model: TodosListModel
    
    @FocusState
    private var focusedField: Todo?
    
    var body: some View {
        NavigationView {
            ZStack {
                if model.todos.isEmpty {
                    VStack {
                        Text("No Todos yet.")
                        Text("Try it out and add one.")
                    }
                } else {
                    List {
                        
                        ForEach(model.todos) { todoItem in
                            TodoView(
                                todo: Binding(
                                    get: { todoItem },
                                    set: { value in
                                        model.didUpdateTodo(value)
                                    }
                                )
                            )
                            .padding(.horizontal, 16)
                            .padding(.vertical, 4)
                        }
                        .onDelete { offset in
                            model.didDeleteTodo(offset)
                            
                        }
                    }
                }
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            model.addTodoButtonTapped()
                        }) {
                            Text("Add")
                        }
                        .disabled(!model.canAddTodos)
                    }
                }
                .padding(.horizontal, 24)
            }
            .navigationTitle("Todos")
        }
    }
}

#if DEBUG
struct TodoListViewFeature_Previews: PreviewProvider {
    static var previews: some View {
        TodoListViewFeature(
            model: .init(
                todos: [
                    .init(
                        id: .init(),
                        text: "Hello World",
                        isCompleted: false,
                        dateAdded: .now
                    ),
                    .init(
                        id: .init(),
                        text: "Hello World, yesterday",
                        isCompleted: true,
                        dateAdded: .now
                    )
                ],
                storageClient: InMemoryStorageClient()
            )
        )
        .previewDisplayName("Light Mode")
        
        TodoListViewFeature(
            model: .init(
                todos: [
                    .init(
                        id: .init(),
                        text: "Hello World",
                        isCompleted: false,
                        dateAdded: .now
                    ),
                    .init(
                        id: .init(),
                        text: "Hello World, yesterday",
                        isCompleted: true,
                        dateAdded: .now
                    )
                ],
                storageClient: InMemoryStorageClient()
            )
        )
        .previewDisplayName("Dark Mode")
        .preferredColorScheme(.dark)
    }
}
#endif
