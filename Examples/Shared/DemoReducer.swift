import ComposableArchitecture
import SwiftUI
import TCACustomAlert

struct AlertDemoReducer: ReducerProtocol {
    
    struct State: Equatable {
        
        var alertState: CustomTcaAlert.State = .init()
        
        var form: Form.State {
            get {
                .init(
                    dismissOnScrimTap: alertState.dismissOnScrimTap,
                    scrimOpacity: alertState.endScrimOpacity,
                    alertStartY: alertState.alertStartPosition.height,
                    alertStartX: alertState.alertStartPosition.width,
                    alertPresentedY: alertState.alertPresentedPosition.height,
                    alertPresentedX: alertState.alertPresentedPosition.width,
                    alertEndY: alertState.alertEndPosition.height,
                    alertEndX: alertState.alertEndPosition.width
                )
            }
            set {
                self.alertState.dismissOnScrimTap = newValue.dismissOnScrimTap
                self.alertState.endScrimOpacity = newValue.scrimOpacity
                self.alertState.alertStartPosition = .init(width: newValue.alertStartX, height: newValue.alertStartY)
                self.alertState.alertPresentedPosition = .init(width: newValue.alertPresentedX, height: newValue.alertPresentedY)
                self.alertState.alertEndPosition = .init(width: newValue.alertEndX, height: newValue.alertEndY)
                
            }
        }
    }
    
    enum Action: Equatable {
        case alert(CustomTcaAlert.Action)
        case form(Form.Action)
    }
    
    var body: some ReducerProtocol<State, Action> {
        Scope(state: \.form, action: /Action.form) {
            Form()
        }
        
        Scope(state: \.alertState, action: /Action.alert) {
            CustomTcaAlert()
        }
    }
    
    struct Form: ReducerProtocol {
        struct State: Equatable {
            @BindableState var dismissOnScrimTap = true
            @BindableState var scrimOpacity = 0.6
            
            @BindableState var alertStartY: CGFloat = 500
            @BindableState var alertStartX: CGFloat = 500
            
            @BindableState var alertPresentedY: CGFloat = 0
            @BindableState var alertPresentedX: CGFloat = 0
            
            @BindableState var alertEndY: CGFloat = -500
            @BindableState var alertEndX: CGFloat = -500
            
            var scrimPercentage: String {
                // Simple formatting for this use case.
                String(format: "%.f%%", scrimOpacity * 100)
            }
        }
        
        enum Action: Equatable, BindableAction {
            case binding(BindingAction<State>)
        }
        
        var body: some ReducerProtocol<State, Action> {
            BindingReducer()
        }
    }
}
