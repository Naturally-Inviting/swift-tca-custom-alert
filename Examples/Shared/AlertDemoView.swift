import ComposableArchitecture
import SwiftUI
import TCACustomAlert

struct AlertDemoView: View {
    private struct AlertDemoReducer: ReducerProtocol {
        struct State: Equatable {
            var alert: CustomTcaAlert.State = .init()
        }
        
        enum Action: Equatable {
            case alert(CustomTcaAlert.Action)
        }
        
        var body: some ReducerProtocol<State, Action> {
            Scope(state: \.alert, action: /Action.alert) {
                CustomTcaAlert()
            }
        }
    }
    
    private let store = Store(
        initialState: .init(),
        reducer: AlertDemoReducer()
    )
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                Button("Present", action: { viewStore.send(.alert(.present)) })
            }
            .customTcaAlert(
                store.scope(
                    state: \.alert,
                    action: AlertDemoReducer.Action.alert
                ),
                content: {
                    VStack(spacing: 16) {
                        Text("Hello")
                            .font(.headline)
                        Text("This is a custom Alert view! You can create any view to be presented. You can tap the scrim to dismiss by default, or you can tap dismiss below.")
                        Button("Dismiss", action: { viewStore.send(.alert(.dismiss)) })
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
}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertDemoView()
    }
}
