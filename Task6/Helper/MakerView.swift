
import Foundation

import UIKit

class MakerView {
    
    static var shared = MakerView()
    
    func makeView (backgroundColor: UIColor = .clear
    ) -> UIView{
        
        let view = UIView()
        
        view.backgroundColor = backgroundColor
        
        return view
        
    }
    
    func makeLabel (text: String = "",
                    textAlign: NSTextAlignment = .center,
                    font: UIFont = .systemFont(ofSize: 12),
                    textColor: UIColor = .white,
                    lines: Int = 0,
                    background: UIColor = .white,
                    cornerRadius: CGFloat = 0,
                    autoResizing: Bool = true
                    
                    
    ) -> UILabel {
        let label = UILabel()
        
        label.text = text
        label.textAlignment = textAlign
        label.font = font
        label.textColor = textColor
        label.numberOfLines = lines
        label.backgroundColor = background
        label.layer.cornerRadius = cornerRadius
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }
    
    
    
    func makeTF (textColor: UIColor = .white,
                 font: UIFont = .systemFont(ofSize: 12),
                 textALign: NSTextAlignment = .left,
                 placeHolder: String = "",
//                 borderStyle: UITextField.BorderStyle = .roundedRect,
                 secureTextEntry: Bool = false,
                 autocorrectionType: UITextAutocorrectionType = .no,
                 borderWidth: CGFloat = 0,
                 borderColor: UIColor = .clear


    ) -> UITextField {
        let textField = UITextField()
        
        textField.textColor = textColor
        textField.font = font
        textField.textAlignment = textALign
        textField.placeholder = placeHolder
//        textField.borderStyle = borderStyle
        textField.isSecureTextEntry = secureTextEntry
        textField.autocorrectionType = autocorrectionType
        textField.layer.borderWidth = borderWidth
        textField.layer.borderColor = borderColor.cgColor
        
        return textField
    }
    
    func makeButton (button: UIButton = UIButton(type: .system),
                     title: String = "",
                     titleColor: UIColor = .white,
                     font: UIFont = .systemFont(ofSize: 12),
                     backgroundColor: UIColor = .clear,
                     cornerRadius: CGFloat = 0,
                     image: UIImage? = nil,
                     tinitColor: UIColor = .clear,
                     isEnabled: Bool = true,
                     isSelected: Bool = false,
                     backgroundImg: UIImage? = nil,
                     autoResizing: Bool = true
                    
    ) -> UIButton {
        let button = button
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.titleLabel?.font = font
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = cornerRadius
        button.setImage(image, for: .normal)
        button.tintColor = tinitColor
        button.isEnabled = isEnabled
        button.isSelected = isSelected
        button.setBackgroundImage(backgroundImg, for: .selected)
        button.translatesAutoresizingMaskIntoConstraints = autoResizing
        return button
    }
}
