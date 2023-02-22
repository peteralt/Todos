import Foundation
import IdentifiedCollections

final class UserDefaultsStorageClient: StorageClient {
    private let key: String = "todos"
    
    func load() -> IdentifiedArrayOf<Todo> {
        var todos: IdentifiedArrayOf<Todo> = []
        if let data = UserDefaults.standard.value(forKey: key) as? Data,
            let decodedTodos = try? JSONDecoder().decode(IdentifiedArrayOf<Todo>.self, from: data) {
            todos = decodedTodos
        }
        return todos
    }
    
    func save(_ todos: IdentifiedArrayOf<Todo>) {
        if let data = try? JSONEncoder().encode(todos) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}
