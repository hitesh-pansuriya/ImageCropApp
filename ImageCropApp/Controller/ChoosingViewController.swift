//
//  ChoosingViewController.swift
//  ImageCropApp
//
//  Created by PC on 10/09/22.
//

import UIKit

class ChoosingViewController: UIViewController {
    var image : UIImage?

    @IBOutlet weak var img: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if image != nil {
            img.image = image
        }
    }

    @IBAction func filterButtonPressed(_ sender: UIButton) {
        goToFilterViewController()
        self.dismiss(animated: false, completion: {})
    }
    

    @IBAction func cropButtonPressed(_ sender: Any) {
        goToEdiditViewController()
        self.dismiss(animated: false, completion: {})
    }
    

    @IBAction func addTextButtonPressed(_ sender: UIButton) {
        goToAddTextViewController()
        self.dismiss(animated: false, completion: {})
    }
    
    func goToEdiditViewController(){
        guard let editVC = self.storyboard?.instantiateViewController(withIdentifier: "EditViewController") as? EditViewController else {
            return
        }
        editVC.image = image
        self.navigationController?.pushViewController(editVC, animated: true)
    }
    
    func goToFilterViewController(){
        guard let filterVC = self.storyboard?.instantiateViewController(withIdentifier: "FilterViewController") as? FilterViewController else {
            return
        }
        filterVC.image = image
        self.navigationController?.pushViewController(filterVC, animated: true)
    }

    func goToAddTextViewController(){
        guard let addTextVC = self.storyboard?.instantiateViewController(withIdentifier: "AddTextViewController") as? AddTextViewController else {
            return
        }
        addTextVC.tImage = image
        self.navigationController?.pushViewController(addTextVC, animated: true)
    }


    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }


    @IBAction func saveButtonPressed(_ sender: UIButton) {
        guard let inputImage = image else {return}

        let imageSaver = ImageSaver()
        imageSaver.writeToPhotoAlbum(image: inputImage)
        self.navigationController?.popToRootViewController(animated: true)
    }

}
