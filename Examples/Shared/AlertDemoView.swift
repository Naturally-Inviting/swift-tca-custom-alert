import ComposableArchitecture
import SwiftUI
import TCACustomAlert

struct AlertDemoView: View {
    
    private let store = Store(
        initialState: .init(),
        reducer: AlertDemoReducer()._printChanges()
    )
    
    var body: some View {
        WithViewStore(store) { viewStore in
            ZStack {
                FormView(
                    store: self.store.scope(
                        state: \.form,
                        action: AlertDemoReducer.Action.form
                    )
                )
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button("Present", action: { viewStore.send(.alert(.present)) })
                            .padding()
                        Spacer()
                    }
                    .background(.thinMaterial)
                }
                .frame(maxWidth: .infinity)
            }
            .customTcaAlert(
                store.scope(
                    state: \.alertState,
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
