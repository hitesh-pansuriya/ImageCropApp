//
//  FilterViewController.swift
//  ImageCropApp
//
//  Created by PC on 09/09/22.
//

import UIKit
import CoreImage
import CoreImage.CIFilterBuiltins

class FilterViewController: UIViewController {

    @IBOutlet weak var horizontalScrollableStack: UIStackView!
    var image: UIImage?

    var filterImageArr =  [UIImage]()

    enum FilterType : String, CaseIterable {
        case Chrome = "CIPhotoEffectChrome"
        case Fade = "CIPhotoEffectFade"
        case Instant = "CIPhotoEffectInstant"
        case Mono = "CIPhotoEffectMono"
        case Noir = "CIPhotoEffectNoir"
        case Process = "CIPhotoEffectProcess"
        case Tonal = "CIPhotoEffectTonal"
        case Transfer =  "CIPhotoEffectTransfer"
    }


    @IBOutlet weak var fImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if image != nil {
            fImage.image = image
        }
        creatButton()

    }

    func creatButton(){
        guard let fImg = image else {return}
        for i in FilterType.allCases{
            let img = addFilter(img: fImg, filter: i)

            let filterButton :UIButton = UIButton()
            filterButton.setImage(img, for: .normal)
            filterButton.backgroundColor = .green
            filterButton.widthAnchor.constraint(equalToConstant: horizontalScrollableStack.frame.height).isActive = true
            filterButton.addTarget(self, action: #selector(filterButtonPressed(_ :)), for: .touchUpInside)
            horizontalScrollableStack.addArrangedSubview(filterButton)
        }
    }

    @objc func filterButtonPressed(_ sender: UIButton){
        guard let img = sender.imageView?.image else {return}
        fImage.image = addFilter(img: img, filter: .Chrome)
    }


    func addFilter(img: UIImage, filter : FilterType) -> UIImage {
        let filter = CIFilter(name: filter.rawValue)
        // convert UIImage to CIImage and set as input
        let ciInput = CIImage(image: img)
        filter?.setValue(ciInput, forKey: "inputImage")
        // get output CIImage, render as CGImage first to retain proper UIImage scale
        let ciOutput = filter?.outputImage
        let ciContext = CIContext()
        let cgImage = ciContext.createCGImage(ciOutput!, from: (ciOutput?.extent)!)
        //Return the image
        return UIImage(cgImage: cgImage!)
    }

    @IBAction func resetButtonPressed(_ sender: UIButton) {
        fImage.image = image
    }
    

    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        if let image = image {
            gotoNextView(image)
        }
    }


    @IBAction func checkButtonClicked(_ sender: UIButton) {
        if let image = fImage.image{
            gotoNextView(image)
        }
    }


    func gotoNextView(_ image: UIImage) {
        guard let ChooseVC = self.storyboard?.instantiateViewController(withIdentifier: "ChoosingViewController") as? ChoosingViewController else {
            return
        }
        ChooseVC.image = image
        self.navigationController?.pushViewController(ChooseVC, animated: true)
    }

}
