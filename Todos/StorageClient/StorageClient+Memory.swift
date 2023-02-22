import Foundation
import IdentifiedCollections

final class InMemoryStorageClient: StorageClient {
    var todos: IdentifiedArrayOf<Todo> = []
    
    func load() -> IdentifiedArrayOf<Todo> {
        todos
    }
    func save(_ todos: IdentifiedArrayOf<Todo>) -> Void {
        self.todos = todos
    }
}

