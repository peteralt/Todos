import XCTest
@testable import Todos

final class TodosTests: XCTestCase {

    /*
     This is just a very basic test sample of how we can make sure our logic works as expected.
     */

    @MainActor
    func testAddingNewTodo() throws {
        let model = TodosListModel(storageClient: InMemoryStorageClient())
        
        XCTAssert(model.todos.isEmpty)
        XCTAssert(model.canAddTodos)
        
        model.addTodoButtonTapped()
        XCTAssertEqual(model.todos.count, 1)
        XCTAssertEqual(model.todos.first!.text, "")
        XCTAssertFalse(model.canAddTodos)
    }

}
