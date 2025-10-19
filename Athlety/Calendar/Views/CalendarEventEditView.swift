//
//  CalendarEventEditView.swift
//  Athlety
//
//  Created by Stefan Lipp on 19.10.25.
//

import EventKitUI
import SwiftUI

struct CalendarEventEditView: UIViewControllerRepresentable {
    let event: EKEvent?
    let eventStore: EKEventStore

    func makeUIViewController(context: Context) -> EKEventEditViewController {
        let viewController = EKEventEditViewController()
        viewController.event = event
        viewController.eventStore = eventStore
        viewController.editViewDelegate = context.coordinator
        viewController.navigationController?.navigationBar.tintColor = .accent
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context _: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator: NSObject, EKEventEditViewDelegate {
        func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith _: EKEventEditViewAction) {
            controller.dismiss(animated: true)
        }
    }
}
