import ComposableArchitecture
import SwiftUI

struct FormView: View {
    let store: StoreOf<AlertDemoReducer.Form>
    
    var body: some View {
        WithViewStore(store) { formViewStore in
            Form {
                Section {
                    Text("Scrim Settings")
                    Toggle("Dismiss on Scrim Tap", isOn: formViewStore.binding(\.$dismissOnScrimTap))
                    HStack {
                        Text("Opacity: \(formViewStore.scrimPercentage)")
                        Slider(
                            value: formViewStore.binding(\.$scrimOpacity),
                            in: 0.1...1,
                            step: 0.1
                        )
                    }
                }
                
                Section {
                    Text("Alert presentation starting position")
                    HStack {
                        Text("X: \(Int(formViewStore.alertStartX))")
                            .frame(width: 80, alignment: .leading)
                        Slider(
                            value: formViewStore.binding(\.$alertStartX),
                            in: -1000...1000,
                            step: 100
                        )
                    }
                    HStack {
                        Text("Y: \(Int(formViewStore.alertStartY))")
                            .frame(width: 80, alignment: .leading)
                        Slider(
                            value: formViewStore.binding(\.$alertStartY),
                            in: -1000...1000,
                            step: 100
                        )
                    }
                }
                
                Section {
                    Text("Alert presented position")
                    HStack {
                        Text("X: \(Int(formViewStore.alertPresentedX))")
                            .frame(width: 80, alignment: .leading)
                        
                        Slider(
                            value: formViewStore.binding(\.$alertPresentedX),
                            in: -300...300,
                            step: 100
                        )
                    }
                    HStack {
                        Text("Y: \(Int(formViewStore.alertPresentedY))")
                            .frame(width: 80, alignment: .leading)
                        Slider(
                            value: formViewStore.binding(\.$alertPresentedY),
                            in: -300...300,
                            step: 100
                        )
                    }
                }
                
                Section {
                    Text("Alert dismissal ending position")
                    HStack {
                        Text("X: \(Int(formViewStore.alertEndX))")
                            .frame(width: 80, alignment: .leading)
                        Slider(
                            value: formViewStore.binding(\.$alertEndX),
                            in: -1000...1000,
                            step: 100
                        )
                    }
                    HStack {
                        Text("Y: \(Int(formViewStore.alertEndY))")
                            .frame(width: 80, alignment: .leading)
                        Slider(
                            value: formViewStore.binding(\.$alertEndY),
                            in: -1000...1000,
                            step: 100
                        )
                    }
                }
            }
        }
    }
}
