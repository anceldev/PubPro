//
//  ErrorView.swift
//  PubPro
//
//  Created by Ancel Dev account on 3/1/25.
//

import SwiftUI

struct ErrorView: View {
    let errorWrapper: ErrorWrapper
    var body: some View {
        VStack {
            Text("Error has ocurred in the application.")
                .font(.headline)
                .padding(.bottom, 10)
            Text(errorWrapper.error.localizedDescription)
            Text(errorWrapper.guidance)
                .font(.caption)
        }
        .padding()
    }
}

#Preview {
    enum PreviewError: Error {
        case operationFailed
    }
    return ErrorView(errorWrapper: .init(error: PreviewError.operationFailed, guidance: "Operation has failed."))
}
