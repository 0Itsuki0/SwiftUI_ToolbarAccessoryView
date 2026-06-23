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
