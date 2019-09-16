import UIKit

class Calculator: UIViewController {
    
    fileprivate var previousOperation: Character = "="
    fileprivate var previousNumber: Int = 0
    fileprivate var number:Int = 0
    fileprivate var memory:Int = 0
    
    @IBOutlet weak var result: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        result.isEnabled = false
    }
    
    @IBAction func button1Click(_ sender: UIButton) {
        addDigit(1)
    }
    
    @IBAction func button2Click(_ sender: UIButton) {
        addDigit(2)
    }
    
    @IBAction func button3Click(_ sender: UIButton) {
        addDigit(3)
    }
    
    @IBAction func button4Click(_ sender: UIButton) {
        addDigit(4)
    }
    
    @IBAction func button5Click(_ sender: UIButton) {
        addDigit(5)
    }
    
    @IBAction func button6Click(_ sender: UIButton) {
        addDigit(6)
    }
    
    @IBAction func button7Click(_ sender: UIButton) {
        addDigit(7)
    }
    
    @IBAction func button8Click(_ sender: UIButton) {
        addDigit(8)
    }
    
    @IBAction func button9Click(_ sender: UIButton) {
        addDigit(9)
    }
    
    @IBAction func button0Click(_ sender: UIButton) {
        addDigit(0)
    }
    
    @IBAction func buttonPlusClick(_ sender: UIButton) {
        doOperation("+")
    }
    
    @IBAction func buttonMinusClick(_ sender: UIButton) {
        doOperation("-")
    }
    
    @IBAction func buttonMultiplyClick(_ sender: UIButton) {
        doOperation("x")
    }
    
    @IBAction func buttonDivideClick(_ sender: UIButton) {
        doOperation("/")
    }
    
    @IBAction func buttonEqualClick(_ sender: UIButton) {
        doOperation("=")
        number = previousNumber
        previousNumber = 0
    }
    
    @IBAction func buttonClearClick(_ sender: UIButton) {
        number = 0
        showInScreen(number)
    }
    
    @IBAction func buttonAddToMemoryClick(_ sender: UIButton) {
        memory += number
        number = 0
    }
    
    @IBAction func buttonRemoveFromMemoryClick(_ sender: UIButton) {
        memory -= number
        number = 0
    }
    
    @IBAction func buttonShowMemoryClick(_ sender: UIButton) {
        number = memory
        showInScreen(number)
    }
    
    @IBAction func buttonClearMemoryClick(_ sender: UIButton) {
        memory = 0
    }
    
    func showInScreen(_ number: Int){
        result.text = String(format: "%d", number)
    }
    
    func addDigit(_ digit: Int){
        number = number * 10 + digit
        showInScreen(number)
    }
    
    func doOperation(_ operation: Character){
        switch (previousOperation) {
            case "+":previousNumber = previousNumber + number
            case "-":previousNumber = previousNumber - number
            case "x":previousNumber = previousNumber * number
            case "/":if (number != 0){
                        previousNumber = previousNumber / number
                    }
            case "=":previousNumber = number
            default:break
        }
        previousOperation = operation
        number = 0
        showInScreen(previousNumber)
    }

}

