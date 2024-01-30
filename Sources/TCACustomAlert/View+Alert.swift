import ComposableArchitecture
import SwiftUI

public extension View {
    @ViewBuilder
    func customTcaAlert(
        _ store: StoreOf<CustomTcaAlert>,
        content: @escaping () -> some View
    ) -> some View {
        self
            .modifier(
                AlertViewModifier(
                    store: store,
                    alertContent: content
                )
            )
    }
}

internal struct AlertViewModifier<AlertContent>: ViewModifier where AlertContent: View {
    let store: StoreOf<CustomTcaAlert>
    let alertContent: () -> AlertContent

    internal init(
        store: StoreOf<CustomTcaAlert>,
        @ViewBuilder alertContent: @escaping () -> AlertContent
    ) {
        self.store = store
        self.alertContent = alertContent
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .allowsHitTesting(store.contentAllowsHitTesting)
            
            Color.black
                .opacity(store.scrimOpacity)
                .opacity(store.endScrimOpacity)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    store.send(.scrimTapped)
                }
            
            alertContent()
                .offset(store.modalOffset)
                .opacity(store.modalOpacity)
        }
    }
}

