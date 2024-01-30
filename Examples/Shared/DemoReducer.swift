import ComposableArchitecture
import SwiftUI
import TCACustomAlert

@Reducer
struct AlertDemoReducer: Reducer {
    @ObservableState
    struct State: Equatable {
        var alertState: CustomTcaAlert.State = .init()
        
        var form: FormFeature.State {
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
        case form(FormFeature.Action)
    }
    
    var body: some Reducer<State, Action> {
        Scope(state: \.form, action: /Action.form) {
            FormFeature()
        }
        
        Scope(state: \.alertState, action: /Action.alert) {
            CustomTcaAlert()
        }
    }
}


@Reducer
struct FormFeature {
    @ObservableState
    struct State: Equatable {
        var dismissOnScrimTap = true
        var scrimOpacity = 0.6
        
        var alertStartY: CGFloat = 500
        var alertStartX: CGFloat = 500
        
        var alertPresentedY: CGFloat = 0
        var alertPresentedX: CGFloat = 0
        
        var alertEndY: CGFloat = -500
        var alertEndX: CGFloat = -500
        
        var scrimPercentage: String {
            // Simple formatting for this use case.
            String(format: "%.f%%", scrimOpacity * 100)
        }
    }
    
    enum Action: Equatable, BindableAction {
        case binding(BindingAction<State>)
    }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
    }
}
