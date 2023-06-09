//
//  AttachementPDFView.swift
//  Athlety
//
//  Created by Stefan Cimander on 10.06.23.
//

import PDFKit
import SwiftUI

struct AttachementPDFView: UIViewRepresentable {
    typealias UIViewType = PDFView

    let url: URL

    func makeUIView(context _: UIViewRepresentableContext<AttachementPDFView>) -> UIViewType {
        let pdfView = PDFView()
        guard let data = try? Data(contentsOf: url) else { return pdfView }
        pdfView.document = PDFDocument(data: data)
        pdfView.autoScales = true
        return pdfView
    }

    func updateUIView(_ pdfView: UIViewType, context _: UIViewRepresentableContext<AttachementPDFView>) { }
}
