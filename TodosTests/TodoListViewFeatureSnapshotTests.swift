import IdentifiedCollections
import SnapshotTesting
import XCTest
@testable import Todos

final class TodoListViewFeatureSnapshotTests: XCTestCase {
    
    /*
     Some very basic snapshot tests to verify the view renders as expected.
     Note: These tests need to be run on iPhone 14 Pro or identical screen sizes, otherwise
     they will fail.
     */
    
    @MainActor
    func testEmptyState() throws {
        let model = TodosListModel(storageClient: InMemoryStorageClient())
        let view = TodoListViewFeature(model: model)
        
        assertSnapshot(matching: view, as: .image)
    }
    
    @MainActor
    func testWithSomeTasks() throws {
        let todos: IdentifiedArrayOf<Todo> = [
            .unfinished,
            .completed
        ]
        let model = TodosListModel(storageClient: InMemoryStorageClient(todos: todos))
        let view = TodoListViewFeature(model: model)
        
        assertSnapshot(matching: view, as: .image)
    }
    
    @MainActor
    func testLastAddedTasksDisablesAddButton() throws {
        let todos: IdentifiedArrayOf<Todo> = [
            .unfinished,
            .completed
        ]
        let model = TodosListModel(storageClient: InMemoryStorageClient(todos: todos))
        model.addTodoButtonTapped()
        let view = TodoListViewFeature(model: model)
        
        assertSnapshot(matching: view, as: .image)
    }

}
