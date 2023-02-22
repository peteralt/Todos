import SwiftUI

struct ContentView: View {
    let storageClient: StorageClient
    
    var body: some View {
        TodoListViewFeature(
            model: .init(
                storageClient: storageClient
            )
        )
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(storageClient: InMemoryStorageClient())
    }
}
#endif
