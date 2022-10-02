//
//  ViewController.swift
//  ImageCropApp
//
//  Created by PC on 05/09/22.
//

import UIKit

class ViewController: UIViewController{

    var imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func addImagePressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Choose source of your image.", message: "", preferredStyle: .actionSheet)


        let galleryAction = UIAlertAction(title: "Gallery", style: .default) { [self] (action) in
            print("gallery is open")
            self.imageSelection(sourceType: ".photoLibrary")
        }


        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
            print("camera is open")

            self.imageSelection(sourceType: ".camera")
        }

        alert.addAction(galleryAction)
        alert.addAction(cameraAction)

        present(alert, animated: true, completion: nil)
    }

}

extension ViewController : UINavigationControllerDelegate, UIImagePickerControllerDelegate{

    func imageSelection(sourceType: String){
        imagePicker.delegate = self

        if sourceType == ".camera"{
            imagePicker.sourceType = .camera
        }else{
            imagePicker.sourceType = .photoLibrary
        }

        imagePicker.allowsEditing = false

        present(imagePicker, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.gotoNextView(image)
        }
        self.dismiss(animated:  true, completion: {})

    }

    func gotoNextView(_ image: UIImage) {
        guard let ChooseVC = self.storyboard?.instantiateViewController(withIdentifier: "ChoosingViewController") as? ChoosingViewController else {
            return
        }
        ChooseVC.image = image
        self.navigationController?.pushViewController(ChooseVC, animated: true)
    }

    
}

