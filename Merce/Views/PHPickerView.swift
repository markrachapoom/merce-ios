//
//  PHPickerView.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/22.
//

import SwiftUI
import PhotosUI

struct PHPickerView: UIViewControllerRepresentable {
    
    let selectionLimit: Int
    @Binding var selectedImage: UIImage?
    
    init(imagesLimit: Int, selectedImage: Binding<UIImage?>) {
        self.selectionLimit = imagesLimit
        self._selectedImage = selectedImage
    }
    
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: - MAKE AND UPDATE
    func makeUIViewController(context: Context) -> PHPickerViewController {
        
        var config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        config.filter = .images
        config.selectionLimit = selectionLimit
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        picker.dismiss(animated: true, completion: {})
        
        return picker
        
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    // MARK: - COORDINATOR
    
    // MAKE
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // COODINATOR CLASS
    class Coordinator: NSObject, UINavigationControllerDelegate, PHPickerViewControllerDelegate {
        
        private let parent: PHPickerView
        
        init(_ parent: PHPickerView) {
            self.parent = parent
        }
        
        // picker func from protocol
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            
            picker.dismiss(animated: true)
            
            for image in results {
                image.itemProvider.loadObject(ofClass: UIImage.self) { selectedImage, error  in

                    if let error = error {
                        // If error happens
                        print(error.localizedDescription)
                        return
                    }

                    // Cast type uiimage
                    guard let uiImage = selectedImage as? UIImage else {
                        print("unable to unwrap image as UIImage")
                        return
                    }
                    
                    // Asynchronously swap the image in view
                    DispatchQueue.main.async {
//                        self.parent.withInteractiveSpring {
                            self.parent.selectedImage = uiImage
//                        }
                    }
                    
                    self.parent.presentationMode.wrappedValue.dismiss()
                }
            }
        }//: FUNC PICKER

    }
}
