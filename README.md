# SwiftUI_ToolbarAccessoryView

A reusable view modifier for creating toolbar accessory view in SwiftUI/MacOS.

Sample Usage

```swift
Text("Some Main Content")
    .navigationTitle("Itsuki")
    .accessoryView {
        Text("✨ Is the best! ✨")
            .font(.headline)
            .foregroundColor(.secondary)
        .padding(.all)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
```

For more details, please refer to my blog [SwiftUI/MacOS: Add An Toolbar Accessory View]()

![](./demo.png)


### Side Note
If you don't insist in having an actual Toolbar Accessory View, but just want to achieve something visually similar (same), we can actually do that with pure SwiftUI, by 
1. Set the toolbar background to hidden to remove the bottom border
2. VStack the custom Accessory view with the actual content

```swift
VStack(spacing: 0) {
    YourAccessoryToolbarView()
    Divider()
        .opacity(0.5)
    Text("Some Main Content")
        .frame(maxHeight: .infinity)

}
.toolbarBackground(.hidden, for: .windowToolbar)
```




