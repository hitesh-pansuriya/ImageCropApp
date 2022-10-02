//
//  AddTextViewController.swift
//  ImageCropApp
//
//  Created by PC on 12/09/22.
//

import UIKit

class AddTextViewController: UIViewController {

    var colorsArray = [UIColor.white, UIColor.black, UIColor.yellow]
    var fontNamesArray = ["AcademyEngravedLetPlain", "AlNile-Bold", "Chalkduster"]
    var textAlphaArray = [0.3, 0.6, 1.0]
    var lineSpacings = [1,30,50]
    var shadowOffsets = [1.0, 10.0, 20.0]
//    var tcolor: UIColor = .white{
//        didSet{
//            tImageView.textColor =  tcolor
//        }
//    }
    var textColorBool  = false
    var tImage: UIImage?

    @IBOutlet weak var tImageView: JLStickerImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        if tImage != nil {
            tImageView.image = tImage
        }
       // tImageView.limitImageViewToSuperView()
        tImageView.center = self.view.center
        tImageView.contentMode = .scaleAspectFit
    }

    @IBAction func addButtonPressed(_ sender: UIButton) {
        tImageView.addLabel()

        tImageView.textColor = UIColor.white
        tImageView.textAlpha = 1
        tImageView.currentlyEditingLabel.closeView!.image = UIImage(named: "cancel")
        tImageView.currentlyEditingLabel.rotateView?.image = UIImage(named: "rotate")
        tImageView.currentlyEditingLabel.border?.strokeColor = UIColor.white.cgColor
    }

    @IBAction func refreshShadowButtonPressed(_ sender: UIButton) {
        let index = arc4random_uniform(3)
        let shadowOffset = shadowOffsets[Int(index)]

        tImageView.textShadowOffset = CGSize(width: CGFloat(shadowOffset), height: 10)
        callColorPicker()
    }


    @IBAction func colourButtonPreesed(_ sender: UIButton) {
//        let index = arc4random_uniform(3)
//        let color = colorsArray[Int(index)]
//        tImageView.textColor = color
        textColorBool = true
        callColorPicker()
    }

    @IBAction func fontButtonPessed(_ sender: UIButton) {
        let index = arc4random_uniform(3)
        let fontName = fontNamesArray[Int(index)]

        tImageView.fontName = fontName
    }

    @IBAction func lineSpaciningButtonPressed(_ sender: UIButton) {
        let index = arc4random_uniform(3)
        let lineSpacing = lineSpacings[Int(index)]

        tImageView.lineSpacing = CGFloat(lineSpacing)
    }

    
    @IBAction func alphaButtonPressed(_ sender: Any) {
        let index = arc4random_uniform(3)
        let textAlpha = textAlphaArray[Int(index)]

        tImageView.textAlpha = CGFloat(textAlpha)

    }

    func callColorPicker(){
        let colourPickerVC = UIColorPickerViewController()
        colourPickerVC.delegate = self
        present(colourPickerVC, animated: true  )
    }


    @IBAction func cancelButtonClicked(_ sender: UIButton) {
        if let image = tImage{
            gotoNextView(image)
        }
    }



    @IBAction func checkButtonClicked(_ sender: UIButton) {
        tImageView.currentlyEditingLabel.hideEditingHandlers()
        if let image = tImageView.renderTextOnView(tImageView){
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

extension AddTextViewController : UIColorPickerViewControllerDelegate{
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        if textColorBool {
            tImageView.textColor = viewController.selectedColor
        }else{
            tImageView.textShadowColor = viewController.selectedColor
        }
    }

    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        if textColorBool {
            tImageView.textColor = viewController.selectedColor
        }else{
            tImageView.textShadowColor = viewController.selectedColor
        }
        textColorBool = false
    }

}
