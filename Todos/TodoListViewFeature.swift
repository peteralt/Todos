import IdentifiedCollections
import Combine

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
    
    func didUpdateTodo(todo: Todo) {
        self.todos[id: todo.id] = todo
        canAddTodos = todo.text != ""
    }
    
    func todoTapped() {
        
    }
    
    func toggleTodoState() {
        
    }
    
    private func bind() {
        
    }
}

struct Todo: Equatable, Identifiable, Codable, Hashable {
    var id: UUID
    var text: String
    var isCompleted: Bool
    var dateAdded: Date
}

import SwiftUI

struct TodoView: View {
    @Binding
    var todo: Todo
    
    var icon: Image {
        if todo.isCompleted {
            return Image(systemName: "checkmark.circle.fill")
        } else {
            return Image(systemName: "circle")
        }
    }
    
    var body: some View {
        HStack {
            icon
            TextField("", text: $todo.text)
            Spacer()
        }
    }
}

struct TodoListViewFeature: View {
    @ObservedObject
    var model: TodosListModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(model.todos) { todo in
                    TodoView(
                        todo: Binding(
                            get: { todo },
                            set: { value in
                                model.didUpdateTodo(todo: value)
                            }
                        )
                    )
                    .padding(.horizontal, 16)
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("Todos")
            .overlay {
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
    }
}
