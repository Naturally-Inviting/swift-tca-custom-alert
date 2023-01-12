import ComposableArchitecture
import SwiftUI

public struct CustomTcaAlert: ReducerProtocol {
    public struct State: Equatable {
        /// X, Y postion where the alert will appear from.
        /// Defaults to bottom of the screen.
        public var alertStartPosition: CGSize
        /// X, Y position where the alert will be when shown to the user.
        /// Defaults to center of the screen.
        public var alertPresentedPosition: CGSize
        /// X, Y position where the alert will dismiss towards.
        /// Defaults to top of screen.
        public var alertEndPosition: CGSize
        /// Opacity of the scrim view behind the modal.
        /// Defaults to 60%.
        public var endScrimOpacity: CGFloat
        /// Boolean reflecting if tapping the scrim view will dismiss the alert.
        /// Defaults to `true`.
        /// Dismissal requires sending ``RealtimeAlert.Action.dismiss`` into the reducer.
        public var dismissOnScrimTap: Bool
        /// Boolean reflecting if the alert is currently presented.
        public internal(set) var isPresented: Bool
        
        // Animated propertes should not be available outside
        // the scope of the Reducer
        
        internal var modalOffset: CGSize
        internal var modalOpacity: CGFloat
        internal var scrimOpacity: CGFloat
        internal var contentAllowsHitTesting: Bool
        
        public init(
            alertStartPosition: CGSize = .init(width: 0, height: 500),
            alertPresentedPosition: CGSize = .zero,
            alertEndPosition: CGSize = .init(width: 0, height: -500),
            endScrimOpacity: CGFloat = 0.6,
            dismissOnScrimTap: Bool = true
        ) {
            self.alertStartPosition = alertStartPosition
            self.alertEndPosition = alertEndPosition
            self.alertPresentedPosition = alertPresentedPosition
            self.endScrimOpacity = endScrimOpacity
            self.modalOffset = alertStartPosition
            self.modalOpacity = .zero
            self.scrimOpacity = .zero
            self.contentAllowsHitTesting = true
            self.isPresented = false
            self.dismissOnScrimTap = dismissOnScrimTap
        }
    }
    
    public enum Action: Equatable {
        case present
        case dismiss
        case scrimTapped
        case scrimOpacityChanged(opacity: CGFloat)
        case modalOffsetChanged(offset: CGSize)
        case modalOpacityChanged(opacity: CGFloat)
    }
    
    @Dependency(\.continuousClock) var clock
    
    public init() {}
    
    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .present:
            state.isPresented = true
            state.contentAllowsHitTesting = false

            return .concatenate(
                .run { [position = state.alertPresentedPosition] send in
                    await send(.modalOffsetChanged(offset: position), animation: .spring())
                },
                .run { send in
                    await send(.modalOpacityChanged(opacity: 1), animation: .default)
                },
                .run { send in
                    await send(.scrimOpacityChanged(opacity: 1), animation: .default)
                }
            )
            
        case .dismiss:
            state.isPresented = false
            state.contentAllowsHitTesting = true
            return .concatenate(
                .run { [end = state.alertEndPosition] send in
                    await send(.modalOffsetChanged(offset: end), animation: .easeInOut)
                },
                .run { send in
                    await send(.modalOpacityChanged(opacity: .zero), animation: .default)
                },
                .run { send in
                    await send(.scrimOpacityChanged(opacity: .zero), animation: .default)
                },
                .task { [start = state.alertStartPosition] in
                    /// After a delay, reset the original position of the modal.
                    try await clock.sleep(for: .milliseconds(500))
                    return .modalOffsetChanged(offset: start)
                }
            )
            
        case .scrimTapped:
            guard state.dismissOnScrimTap else { return .none }
            return .task { .dismiss }
            
        case let .modalOffsetChanged(offset):
            state.modalOffset = offset
            return .none
            
        case let .modalOpacityChanged(opacity):
            state.modalOpacity = opacity
            return .none
            
        case let .scrimOpacityChanged(opacity):
            state.scrimOpacity = opacity
            return .none
        }
    }
}
