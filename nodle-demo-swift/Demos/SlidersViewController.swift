
import UIKit
import nodle

class SlidersViewController: UIViewController {
    
    private var redSlider: UISlider
    private var greenSlider: UISlider
    private var blueSlider: UISlider
    
    private var nodes: [Node] = []
    private var rgbNode: RGBNode

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        rgbNode = RGBNode()
        redSlider = UISlider(frame: .zero)
        greenSlider = UISlider(frame: .zero)
        blueSlider = UISlider(frame: .zero)
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        rgbNode = RGBNode()
        redSlider = UISlider(frame: .zero)
        greenSlider = UISlider(frame: .zero)
        blueSlider = UISlider(frame: .zero)
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        
        let assembleColorNode = AssembleColorNode()
        let updateBackgroundColorNode = UpdateBackgroundColorNode(view: self.view)
        
        // Connect the RGBNode to the AssembleColorNode
        rgbNode.rOutput.addConnection(assembleColorNode.rInput)
        rgbNode.gOutput.addConnection(assembleColorNode.gInput)
        rgbNode.bOutput.addConnection(assembleColorNode.bInput)
        
        // Connect the AssembleColorNode to the UpdateBackgroundColorNode
        assembleColorNode.colorOutput.addConnection(updateBackgroundColorNode.colorInput)
        
        // Store all nodes to make sure they do not go out of scope
        nodes.append(contentsOf: [rgbNode, assembleColorNode, updateBackgroundColorNode])
        
        // Trigger slider callbacks to make sure the initial value is correct
        redSliderValueChanged(redSlider)
        greenSliderValueChanged(greenSlider)
        blueSliderValueChanged(blueSlider)
    }
    
    @objc func redSliderValueChanged(_ sender: Any) {
        guard let slider = sender as? UISlider else {
            return
        }
        
        rgbNode.rInput.value = NSNumber(value: slider.value)
    }
    
    @objc func greenSliderValueChanged(_ sender: Any) {
        guard let slider = sender as? UISlider else {
            return
        }
        
        rgbNode.gInput.value = NSNumber(value: slider.value)
    }
    
    @objc func blueSliderValueChanged(_ sender: Any) {
        guard let slider = sender as? UISlider else {
            return
        }
        
        rgbNode.bInput.value = NSNumber(value: slider.value)
    }
    
    func setupLayout() {
        redSlider.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(redSlider)
        redSlider.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40.0).isActive = true
        redSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        redSlider.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier:0.8).isActive = true
        redSlider.addTarget(self, action: #selector(redSliderValueChanged(_:)), for: .valueChanged)
        
        greenSlider.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(greenSlider)
        greenSlider.topAnchor.constraint(equalTo: redSlider.bottomAnchor, constant: 20.0).isActive = true
        greenSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        greenSlider.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier:0.8).isActive = true
        greenSlider.addTarget(self, action: #selector(greenSliderValueChanged(_:)), for: .valueChanged)
        
        blueSlider.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(blueSlider)
        blueSlider.topAnchor.constraint(equalTo: greenSlider.bottomAnchor, constant: 20.0).isActive = true
        blueSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        blueSlider.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier:0.8).isActive = true
        blueSlider.addTarget(self, action: #selector(blueSliderValueChanged(_:)), for: .valueChanged)
    }
}

