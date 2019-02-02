
import UIKit
import nodle

class ViewController: UIViewController {
    
    private var nodes: [Node] = []
    private var rgbNode: RGBNode

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.rgbNode = RGBNode()
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.rgbNode = RGBNode()
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let assembleColorNode = AssembleColorNode()
        let updateBackgroundColorNode = UpdateBackgroundColorNode(view: self.view)
        
        rgbNode.rOutput.addConnection(assembleColorNode.rInput)
        rgbNode.gOutput.addConnection(assembleColorNode.gInput)
        rgbNode.bOutput.addConnection(assembleColorNode.bInput)
        
        assembleColorNode.colorOutput.addConnection(updateBackgroundColorNode.colorInput)
        
        nodes.append(contentsOf: [rgbNode, assembleColorNode, updateBackgroundColorNode])
        
        rgbNode.rInput.value = (0.5)
        rgbNode.gInput.value = (0.5)
        rgbNode.bInput.value = (0.5)
    }

    @IBAction func redSliderValueChanged(_ sender: Any) {
        guard let slider = sender as? UISlider else {
            return
        }
        
        rgbNode.rInput.value = NSNumber(value: slider.value)
    }
    
    @IBAction func greenSliderValueChanged(_ sender: Any) {
        guard let slider = sender as? UISlider else {
            return
        }
        
        rgbNode.gInput.value = NSNumber(value: slider.value)
    }
    
    @IBAction func blueSliderValueChanged(_ sender: Any) {
        guard let slider = sender as? UISlider else {
            return
        }
        
        rgbNode.bInput.value = NSNumber(value: slider.value)
    }
}

