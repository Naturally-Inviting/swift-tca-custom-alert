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
                    viewStore: ViewStore(store),
                    alertContent: content
                )
            )
    }
}

internal struct AlertViewModifier<AlertContent>: ViewModifier where AlertContent: View {
    @ObservedObject var viewStore: ViewStoreOf<CustomTcaAlert>
    let alertContent: () -> AlertContent

    internal init(
        viewStore: ViewStoreOf<CustomTcaAlert>,
        @ViewBuilder alertContent: @escaping () -> AlertContent
    ) {
        self.viewStore = viewStore
        self.alertContent = alertContent
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .allowsHitTesting(viewStore.contentAllowsHitTesting)
            
            Color.black
                .opacity(viewStore.scrimOpacity)
                .opacity(viewStore.endScrimOpacity)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    viewStore.send(.scrimTapped)
                }
            
            alertContent()
                .offset(viewStore.modalOffset)
                .opacity(viewStore.modalOpacity)
        }
    }
}

