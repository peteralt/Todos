//
//  ContentView.swift
//  Todos
//
//  Created by Peter Alt on 2/21/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TodoListViewFeature(model: .init(todos: []))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
