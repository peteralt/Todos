import Foundation
import Tagged

struct Todo: Equatable, Identifiable, Codable, Hashable {
    var id: Tagged<Self, UUID>
    var text: String
    var isCompleted: Bool
    var dateAdded: Date
}

#if DEBUG
extension Todo {
    static var unfinished: Self {
        .init(
            id: .init(rawValue: .init()),
            text: "Sample Todo, unfinished",
            isCompleted: false,
            dateAdded: .now
        )
    }
    
    static var completed: Self {
        .init(
            id: .init(rawValue: .init()),
            text: "Sample Todo, completed",
            isCompleted: true,
            dateAdded: .now
        )
    }
}
#endif
