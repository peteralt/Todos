import Combine
import Foundation
import IdentifiedCollections

@MainActor
final class TodosListModel: ObservableObject {
    @Published
    var todos: IdentifiedArrayOf<Todo>
    
    @Published
    var canAddTodos: Bool = true
    
    var storageClient: StorageClient
    
    private var cancellables: [AnyCancellable] = []
    
    init(todos: IdentifiedArrayOf<Todo> = [], storageClient: StorageClient) {
        self.todos = todos
        self.storageClient = storageClient
        self.todos = storageClient.load()
        self.bind()
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
        $todos
            .receive(on: DispatchQueue.main)
            .removeDuplicates()
            .sink(receiveValue: { todos in
                self.storageClient.save(todos)
            })
            .store(in: &cancellables)
    }
}
