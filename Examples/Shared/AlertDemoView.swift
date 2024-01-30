import ComposableArchitecture
import SwiftUI
import TCACustomAlert

struct AlertDemoView: View {
    
    let store = Store(
        initialState: .init(),
        reducer: {
            AlertDemoReducer()
                ._printChanges()
        }
    )
    
    var body: some View {
        ZStack {
            FormView(
                store: self.store.scope(
                    state: \.form,
                    action: \.form
                )
            )
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button("Present", action: { store.send(.alert(.present)) })
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
                action: \.alert
            ),
            content: {
                VStack(spacing: 16) {
                    Text("Hello")
                        .font(.headline)
                    Text("This is a custom Alert view! You can create any view to be presented. You can tap the scrim to dismiss by default, or you can tap dismiss below.")
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

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertDemoView()
    }
}
