//
//  CalendarEventEditView.swift
//  Athlety
//
//  Created by Stefan Lipp on 04.04.24.
//

import SwiftUI
import UIKit
import EventKitUI

struct CalendarEventEditView: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = EKEventEditViewController
    
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var event: EKEvent?
    
    let eventStore: EKEventStore
    
    func makeUIViewController(context: Context) -> EKEventEditViewController {
        let controller = EKEventEditViewController()
        controller.eventStore = eventStore
        controller.event = event
        controller.editViewDelegate = context.coordinator
        controller.setNavigationBarHidden(true, animated: true)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: EKEventEditViewController, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator: NSObject, EKEventEditViewDelegate {
        var parent: CalendarEventEditView
        
        init(_ parent: CalendarEventEditView) {
            self.parent = parent
        }
        
        func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
