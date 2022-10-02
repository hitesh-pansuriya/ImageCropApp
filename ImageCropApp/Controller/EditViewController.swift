//
//  EditViewController.swift
//  ImageCropApp
//
//  Created by PC on 05/09/22.
//

import UIKit
import IGRPhotoTweaks
import HorizontalDial


class EditViewController: IGRPhotoTweakViewController {
    @IBOutlet weak var angleSlider: UISlider!

    @IBOutlet weak var horizontallyScrollableStackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        super.delegate = self
        setupSlider()
    }

    fileprivate func setupSlider() {
        self.angleSlider?.minimumValue = Float(IGRRadianAngle.toRadians(0))
        self.angleSlider?.maximumValue = Float(IGRRadianAngle.toRadians(360))
        self.angleSlider?.value = 0.0
    }

    @IBAction func onChandeAngleSliderValue(_ sender: UISlider) {
        let radians: CGFloat = CGFloat(sender.value)
        super.changedAngle(value: radians)
    }
   
    @IBAction func onTouchAspectButton(_ sender: UIButton) {
        let actionSheet = UIAlertController(title: nil,
                                            message: nil,
                                            preferredStyle: .actionSheet)


        actionSheet.addAction(UIAlertAction(title: "Original", style: .default) { (action) in
            self.resetAspectRect()
        })

        actionSheet.addAction(UIAlertAction(title: "Squere", style: .default) { (action) in
            self.setCropAspectRect(aspect: "1:1")
        })

        actionSheet.addAction(UIAlertAction(title: "2:3", style: .default) { (action) in
            self.setCropAspectRect(aspect: "2:3")
        })

        actionSheet.addAction(UIAlertAction(title: "3:5", style: .default) { (action) in
            self.setCropAspectRect(aspect: "3:5")
        })

        actionSheet.addAction(UIAlertAction(title: "3:4", style: .default) { (action) in
            self.setCropAspectRect(aspect: "3:4")
        })

        actionSheet.addAction(UIAlertAction(title: "5:7", style: .default) { (action) in
            self.setCropAspectRect(aspect: "5:7")
        })

        actionSheet.addAction(UIAlertAction(title: "9:16", style: .default) { (action) in
            self.setCropAspectRect(aspect: "9:16")
        })

        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        present(actionSheet, animated: true, completion: nil)
    }

    @IBAction func onTouchCropButton(_ sender: UIButton) {
        self.cropAction()
    }

    
    @IBAction func onTouchResetButton(_ sender: Any) {
        self.angleSlider?.value = 0.0
        self.resetView()
    }
}

extension EditViewController: IGRPhotoTweakViewControllerDelegate{
    func photoTweaksController(_ controller: IGRPhotoTweakViewController, didFinishWithCroppedImage croppedImage: UIImage) {
        gotoNextView(croppedImage)
        self.dismiss(animated: true, completion: {})

    }

    func photoTweaksControllerDidCancel(_ controller: IGRPhotoTweakViewController) {

    }

    func gotoNextView(_ image: UIImage) {
        guard let ChooseVC = self.storyboard?.instantiateViewController(withIdentifier: "ChoosingViewController") as? ChoosingViewController else {
            return
        }
        ChooseVC.image = image
        self.navigationController?.pushViewController(ChooseVC, animated: true)
    }
}
