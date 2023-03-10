# TODOs

## Requirements

* Xcode 14.2

* iOS 15.6+

* For snapshot tests make sure to run on iPhone 14 Pro or equivalent screen size

## Libraries used

* [Tagged](https://github.com/pointfreeco/swift-tagged) by PointFree to make sure we're using type-safe IDs for our Todos

* [IdentifiedCollections](https://github.com/pointfreeco/swift-identified-collections) by PointFree to make handling Todos easier within SwiftUI

* [SnapshotTesting](https://github.com/pointfreeco/swift-snapshot-testing) by PointFree to enable view snapshots

## Notes

The app is built using the MVVM architecture, we have a viewModel for our ListView Feature, which communicates with a StorageClient in order to persist data into UserDefaults.
The decision for UserDefaults was made because it's lightweight data currently and we have synchronous access to the data and don't have to worry about failures.

Further, some tests have been added, mainly to demonstrate how we can test our viewModel as well as the view itself using snapshot tests. Not all properties have been properly injected, mainly around UUIDs for example as well as dates.

The app supports dark more in a basic fashion, previews have been added.

> A Paragraph of freeform text

This wasn't clearly defined as an input field that requires multi-line text input. Due to the nature of `TextEditor` and its hard to control behavior, I opted to use `TextField` instead, allowing only a single line of text entry at the time. If more time would be allotted to the feature, I would opt to wrap a `UITextView` in a `UIViewRepresentable`. In my experience this is far from ideal, but still a better solution than utilizing `TextEditor`.
