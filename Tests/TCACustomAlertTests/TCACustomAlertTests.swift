import ComposableArchitecture
@testable import TCACustomAlert
import XCTest

final class TCACustomAlertTests: XCTestCase {
    @MainActor
    func testAlertPresentation() async throws {
        let store = TestStore(
            initialState: .init(),
            reducer: { CustomTcaAlert() }
        )
     
        let present = await store.send(.present) {
            $0.isPresented = true
            $0.contentAllowsHitTesting = false
        }
        
        await store.receive(.modalOffsetChanged(offset: .zero)) {
            $0.modalOffset = .zero
        }
        
        await store.receive(.modalOpacityChanged(opacity: 1)) {
            $0.modalOpacity = 1
        }
        
        await store.receive(.scrimOpacityChanged(opacity: 1)) {
            $0.scrimOpacity = 1
        }
        
        await present.cancel()
    }
    
    @MainActor
    func testAlertDismiss() async throws {
        let store = TestStore(
            initialState: .init(
                modalOffset: .zero,
                modalOpacity: 1.0,
                scrimOpacity: 1.0,
                contentAllowsHitTesting: false,
                isPresented: true
            ),
            reducer: { CustomTcaAlert() }
        )
        
        let clock = TestClock()
        store.dependencies.continuousClock = clock
        
        let startPosition = CGSize(width: 0, height: 500)
        let endPosition = CGSize(width: 0, height: -500)
        
        let task = await store.send(.dismiss) {
            $0.isPresented = false
            $0.contentAllowsHitTesting = true
        }
        
        await store.receive(.modalOffsetChanged(offset: endPosition)) {
            $0.modalOffset = endPosition
        }

        await store.receive(.modalOpacityChanged(opacity: .zero)) {
            $0.modalOpacity = .zero
        }

        await store.receive(.scrimOpacityChanged(opacity: .zero)) {
            $0.scrimOpacity = .zero
        }

        await clock.advance(by: .milliseconds(500))

        await store.receive(.modalOffsetChanged(offset: startPosition)) {
            $0.modalOffset = startPosition
        }

        await task.cancel()
    }
    
    @MainActor
    func testScrimTap() async throws {
        let store = TestStore(
            initialState: .init(
                modalOffset: .zero,
                modalOpacity: 1.0,
                scrimOpacity: 1.0,
                contentAllowsHitTesting: false,
                isPresented: true
            ),
            reducer: { CustomTcaAlert() }
        )
        
        let clock = TestClock()
        store.dependencies.continuousClock = clock
        
        let startPosition = CGSize(width: 0, height: 500)
        let endPosition = CGSize(width: 0, height: -500)
        
        let task = await store.send(.scrimTapped)
        
        await store.receive(.dismiss) {
            $0.isPresented = false
            $0.contentAllowsHitTesting = true
        }
        
        await store.receive(.modalOffsetChanged(offset: endPosition)) {
            $0.modalOffset = endPosition
        }

        await store.receive(.modalOpacityChanged(opacity: .zero)) {
            $0.modalOpacity = .zero
        }

        await store.receive(.scrimOpacityChanged(opacity: .zero)) {
            $0.scrimOpacity = .zero
        }

        await clock.advance(by: .milliseconds(500))

        await store.receive(.modalOffsetChanged(offset: startPosition)) {
            $0.modalOffset = startPosition
        }

        await task.cancel()
    }
    
    @MainActor
    func testDisableScrimTap() async throws {
        let store = TestStore(
            initialState: .init(
                dismissOnScrimTap: false,
                modalOffset: .zero,
                modalOpacity: 1.0,
                scrimOpacity: 1.0,
                contentAllowsHitTesting: false,
                isPresented: true
            ),
            reducer: { CustomTcaAlert() }
        )

        let task = await store.send(.scrimTapped)
        await task.cancel()
    }
}
