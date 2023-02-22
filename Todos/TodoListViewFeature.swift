import IdentifiedCollections
import Combine
import Tagged

@MainActor
final class TodosListModel: ObservableObject {
    @Published
    var todos: IdentifiedArrayOf<Todo>
    
    @Published
    var canAddTodos: Bool = true
    
    init(todos: IdentifiedArrayOf<Todo>) {
        self.todos = todos
    }
    
    func addTodoButtonTapped() {
        guard self.todos.last?.text != "" else {
            return
        }
        self.todos.append(
            .init(
                id: .init(),
                text: "",
                isCompleted: false,
                dateAdded: .now
            )
        )
        canAddTodos = false
    }
    
    func didUpdateTodo(_ todo: Todo) {
        self.todos[id: todo.id] = todo
        canAddTodos = todo.text != ""
    }
    
    func didDeleteTodo(_ offset: IndexSet) {
        self.todos.remove(atOffsets: offset)
    }
    
    private func bind() {
        
    }
}

struct Todo: Equatable, Identifiable, Codable, Hashable {
    var id: Tagged<Self, UUID>
    var text: String
    var isCompleted: Bool
    var dateAdded: Date
}

import SwiftUI

struct TodoView: View {
    @Binding
    var todo: Todo
    
    @FocusState
    private var isFocused: Bool
    
    var titleColor: Color {
        if todo.isCompleted {
            return Color.red
        } else {
            return Color(UIColor.label)
        }
    }
    
    var icon: Image {
        if todo.isCompleted {
            return Image(systemName: "checkmark.circle.fill")
        } else {
            return Image(systemName: "circle")
        }
    }
    
    var body: some View {
        HStack {
            Button(action: {
                todo.isCompleted.toggle()
            }) {
                icon
                    .foregroundColor(titleColor)
            }
            TextField("", text: $todo.text)
                .focused($isFocused)
                .foregroundColor(titleColor)
            Spacer()
        }
        .onAppear {
            // we only want to assign focus when adding
            // a new todo, not generally for the last item.
            if todo.text == "" {
                isFocused = true
            }
        }
    }
}

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
                ]
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
                ]
            )
        )
        .previewDisplayName("Dark Mode")
        .preferredColorScheme(.dark)
    }
}
