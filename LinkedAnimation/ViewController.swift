import UIKit

class ViewController: UIViewController {
    
    private lazy var dynamicView: UIView = {
        let dynamicView = UIView()
        dynamicView.backgroundColor = .green
        dynamicView.frame = CGRect(x: view.layoutMargins.left, y: 100, width: 100, height: 100)
        dynamicView.layer.cornerRadius = 8
        return dynamicView
    }()
    
    private lazy var sliderForView: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = .pi / 2
        slider.tintColor = .green
        slider.frame = CGRect(x: view.layoutMargins.left,
                              y: 270,
                              width: view.bounds.width - view.layoutMargins.left - view.layoutMargins.right,
                              height: 20)
        slider.addTarget(self, action: #selector(rotateAndScaleImage(_:)), for: .valueChanged)
        slider.addTarget(self, action: #selector(letBeingAnimated), for: .touchUpInside)
        return slider
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        view.addSubview(dynamicView)
        view.addSubview(sliderForView)
    }
    
    @objc func letBeingAnimated(_ sender: UISlider) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
            self.dynamicView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                                        .rotated(by: .pi / 2)
            self.dynamicView.frame.origin.x = self.view.frame.width - self.dynamicView.frame.width
                                            - self.view.layoutMargins.right
            self.sliderForView.value = self.sliderForView.maximumValue
        }
    }
    
    @objc func rotateAndScaleImage(_ sender: UISlider) {
        let rotationAngle = CGFloat(sender.value)
        let scale = 1.0 + sender.value / .pi
        
        let screenWidthLeft = self.view.frame.width - view.layoutMargins.left
                            - dynamicView.frame.width - view.layoutMargins.right
        
        let sliderFraction = CGFloat(sender.value / sender.maximumValue)
        
        let newCenterX = screenWidthLeft * sliderFraction
                        + dynamicView.frame.width / 2 + view.layoutMargins.left

        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
            self.dynamicView.transform = CGAffineTransform(rotationAngle: rotationAngle)
                                            .scaledBy(x: CGFloat(scale), y: CGFloat(scale))
            self.dynamicView.center.x = newCenterX
        }
    }
}
