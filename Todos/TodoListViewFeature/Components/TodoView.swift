import SwiftUI

struct TodoView: View {
    @Binding
    var todo: Todo
    
    @FocusState
    private var isFocused: Bool
    
    var titleColor: Color {
        if todo.isCompleted {
            return Color.red
        } else {
            return Color(UIColor.label)
        }
    }
    
    var icon: Image {
        if todo.isCompleted {
            return Image(systemName: "checkmark.circle.fill")
        } else {
            return Image(systemName: "circle")
        }
    }
    
    var body: some View {
        HStack {
            Button(action: {
                todo.isCompleted.toggle()
            }) {
                icon
                    .foregroundColor(titleColor)
            }
            TextField("", text: $todo.text)
                .focused($isFocused)
                .foregroundColor(titleColor)
                .onSubmit {
                    isFocused = false
                }
            Spacer()
        }
        .onAppear {
            // we only want to assign focus when adding
            // a new todo, not generally for the last item.
            if todo.text == "" {
                isFocused = true
            }
        }
    }
}

#if DEBUG
struct TodoView_Previews: PreviewProvider {
    static var previews: some View {
        TodoView(todo: .constant(.unfinished))
            .previewDisplayName("Unfinished")
        
        TodoView(todo: .constant(.completed))
            .previewDisplayName("Completed")
    }
}
#endif
