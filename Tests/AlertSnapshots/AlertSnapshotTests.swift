import ComposableArchitecture
@testable import TCACustomAlert
import SnapshotTesting
import SwiftUI
import XCTest

class AlertSnapshotTests: XCTestCase {
    static override func setUp() {
        super.setUp()
        
        SnapshotTesting.diffTool = "ksdiff"
    }
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
//        isRecording = true
    }
    
    override func tearDown() {
        isRecording = false
        
        super.tearDown()
    }
    
    func testAlert() {
        var snapshotView: some View {
            VStack {
                Text("Test")
            }
            .customTcaAlert(
                .init(
                    initialState: .init(
                        modalOffset: .zero,
                        modalOpacity: 1.0,
                        scrimOpacity: 1.0,
                        contentAllowsHitTesting: false,
                        isPresented: true
                    ),
                    reducer: CustomTcaAlert()
                )
            ) {
                VStack(spacing: 16) {
                    Text("Hello")
                        .font(.headline)
                    Text("This is a custom Alert view! You can create any view to be presented. You can tap the scrim to dismiss by default, or you can tap dismiss below.")
                    Button("Dismiss", action: { })
                        .padding(.top)
                }
                .padding()
                .background()
                .cornerRadius(8)
                .padding(.horizontal)
            }
        }
        
        assertSnapshot(
            matching: snapshotView,
            as: .image(layout: .device(config: .iPhone13))
        )
    }
}
