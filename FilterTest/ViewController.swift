//
//  ViewController.swift
//  FilterTest
//
//  Created by Zedd on 2020/05/01.
//  Copyright © 2020 Zedd. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var myImageView: UIImageView!
    var picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.picker.sourceType = .photoLibrary
        self.picker.delegate = self
    }
    
    @IBAction func buttonDidTap(_ sender: Any) {
        self.present(self.picker, animated: true, completion: nil)
    }
        
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let imageURL = info[.imageURL] as? URL, let originalCIImage = CIImage(contentsOf: imageURL)  else { return }
        let context = CIContext()
        let sepiaCIImage = self.sepiaFilter(originalCIImage, intensity: 0.8)!
        let image = UIImage(ciImage: sepiaCIImage)
        self.picker.dismiss(animated: true, completion: {
            self.myImageView.image = image
        })
    }
    
   func sepiaFilter(_ input: CIImage, intensity: Double) -> CIImage? {
        let sepiaFilter = CIFilter(name:"CISepiaTone")
        sepiaFilter?.setValue(input, forKey: kCIInputImageKey)
        sepiaFilter?.setValue(intensity, forKey: kCIInputIntensityKey)
        return sepiaFilter?.outputImage
    }
}

