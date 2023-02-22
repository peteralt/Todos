import Foundation
import IdentifiedCollections

final class InMemoryStorageClient: StorageClient {
    var todos: IdentifiedArrayOf<Todo> = []
    
    init(todos: IdentifiedArrayOf<Todo> = []) {
        self.todos = todos
    }
    
    func load() -> IdentifiedArrayOf<Todo> {
        todos
    }
    func save(_ todos: IdentifiedArrayOf<Todo>) -> Void {
        self.todos = todos
    }
}

