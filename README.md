# TCACustomAlert

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FNaturally-Inviting%2FTCACustomAlert%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/Naturally-Inviting/TCACustomAlert)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fnaturally-inviting%2FTCACustomAlert%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/Naturally-Inviting/TCACustomAlert)
![](https://img.shields.io/badge/coverage-98%25-brightgreen)

## 📝 Description

This package allows for custom alert presentation with [The Composable Architecture](https://github.com/pointfreeco/swift-composable-architecture) from [Point-Free](https://www.pointfree.co).

### Installation 

Install in Xcode as a package dependency.
  1. From the **File** menu, select **Add Packages...**
  2. Enter "https://github.com/Naturally-Inviting/swift-tca-custom-aler" into the package URL field.
     
## Basics 

To create an alert, you need to have a store which can scope the changes of `CustomTcaAlert.State` and `CustomTcaAlert.Action`. Then pass in a view as the alert content.

```swift
import TCACustomAlert

struct MyView: View {
    let store: StoreOf<MyFeature>
    
    var body: some View { 
        VStack {
            ContentView()
        }
        .customTcaAlert(
            store.scope(
                state: \.alertState,
                action: \.alert
            ),
            content: {
                VStack(spacing: 16) {
                    Text("Hello")
                        .font(.headline)
                    Button("Dismiss", action: { store.send(.alert(.dismiss)) })
                        .padding(.top)
                }
                .padding()
                .background()
                .cornerRadius(8)
                .padding(.horizontal)
            }
        )
    }
}
```

### Demo

This demo application can be accessed via `TCACustomAlert.xcworkspace`. 

|Presentation Demo|
|:-:|
|<img src="Demo.gif" width="250"/>|

## 🏎️ Road Map

- [x] Tests
- [ ] Accessibility
