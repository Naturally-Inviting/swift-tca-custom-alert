import ComposableArchitecture
import SwiftUI

struct FormView: View {
    @Perception.Bindable
    var store: StoreOf<FormFeature>
    
    init(store: StoreOf<FormFeature>) {
        self.store = store
    }
    
    var body: some View {
        Form {
            Section {
                Text("Scrim Settings")
                
                Toggle("Dismiss on Scrim Tap", isOn: $store.dismissOnScrimTap)
                HStack {
                    Text("Opacity: \(store.scrimPercentage)")
                    Slider(
                        value: $store.scrimOpacity,
                        in: 0.1...1,
                        step: 0.1
                    )
                }
            }
            
            Section {
                Text("Alert presentation starting position")
                HStack {
                    Text("X: \(Int(store.alertStartX))")
                        .frame(width: 80, alignment: .leading)
                    Slider(
                        value: self.$store.alertStartX,
                        in: -1000...1000,
                        step: 100
                    )
                }
                HStack {
                    Text("Y: \(Int(store.alertStartY))")
                        .frame(width: 80, alignment: .leading)
                    Slider(
                        value: self.$store.alertStartY,
                        in: -1000...1000,
                        step: 100
                    )
                }
            }
            
            Section {
                Text("Alert presented position")
                HStack {
                    Text("X: \(Int(store.alertPresentedX))")
                        .frame(width: 80, alignment: .leading)
                    
                    Slider(
                        value: self.$store.alertPresentedX,
                        in: -300...300,
                        step: 100
                    )
                }
                HStack {
                    Text("Y: \(Int(store.alertPresentedY))")
                        .frame(width: 80, alignment: .leading)
                    Slider(
                        value: self.$store.alertPresentedY,
                        in: -300...300,
                        step: 100
                    )
                }
            }
            
            Section {
                Text("Alert dismissal ending position")
                HStack {
                    Text("X: \(Int(store.alertEndX))")
                        .frame(width: 80, alignment: .leading)
                    Slider(
                        value: self.$store.alertEndX,
                        in: -1000...1000,
                        step: 100
                    )
                }
                HStack {
                    Text("Y: \(Int(store.alertEndY))")
                        .frame(width: 80, alignment: .leading)
                    Slider(
                        value: self.$store.alertEndY,
                        in: -1000...1000,
                        step: 100
                    )
                }
            }
        }
    }
}
