import Foundation
import IdentifiedCollections

protocol StorageClient {
    func load() -> IdentifiedArrayOf<Todo>
    func save(_ todos: IdentifiedArrayOf<Todo>) -> Void
}
