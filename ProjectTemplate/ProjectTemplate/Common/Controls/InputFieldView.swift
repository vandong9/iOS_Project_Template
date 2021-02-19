//
//  InputFieldView.swift
//  VIBChampion
//
//  Created by ha van dong on 1/27/21.
//

import UIKit
import RxSwift
import RxCocoa

struct InputFieldVisual {
    var borderRadius: CGFloat = 5
    let inactiveBorderColor: UIColor
    let activeBorderColor: UIColor
    let errorBorderColor: UIColor
    let inactiveTitleColor: UIColor
    let activeTitleColor: UIColor
    let errorTitleColor: UIColor
    var borderWidth: CGFloat = 1
    
}

protocol IInputFieldViewActions: class {
    func inputFieldView(_ view: InputFieldView, valueChanged: String?)
}


class InputFieldView: UIView {
    enum InputFieldViewStatus {
        case active
        case inactive
        case error
    }
    
    // MARK: - Properties
    
//    // Title
//    @IBOutlet weak var titleStackView: UIStackView!
//    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var requiredMaskLabel: UILabel!
//
//    // Content
//    @IBOutlet weak var contentContainerView: UIView!
//    @IBOutlet weak var contentStackView: UIStackView!
//    @IBOutlet weak var rightView: UIView!
//    @IBOutlet weak var leftView: UIView!
//    @IBOutlet weak var inputTextField: UITextField!
//    @IBOutlet weak var errorLabel: UILabel!

    
    
    // Title
    var titleStackView: UIStackView!
    var titleLabel: UILabel!
    var requiredMaskLabel: UILabel!
    var contentStackView: UIStackView!
    var inputContentContainerView: UIView!
    var inputContentStackView: UIStackView!
    var rightView: UIView?
    var leftView: UIView?
    var inputTextField: UITextField!
    var errorLabel: UILabel!
    
    // callback when textfield end editing
    weak var delegate: IInputFieldViewActions?
    var tapGesture: UITapGestureRecognizer!
    let valueChangeSubject = PublishSubject<String?>()
    var textChangedCallBack: ((String?)->Void)?
    
    var filter: ((String?) -> String?)?
    var decorate: ((String?) -> String?)?
    var restrictTexts: [String] = []
    
    private static let defaultVisual: InputFieldVisual =  InputFieldVisual(borderRadius: AppSize.radius.size, inactiveBorderColor: AppColor.captionInActive.color, activeBorderColor: AppColor.blue.color, errorBorderColor: AppColor.error.color, inactiveTitleColor: AppColor.captionInActive.color, activeTitleColor: AppColor.blue.color, errorTitleColor: AppColor.error.color, borderWidth: 1)
    
    var status: InputFieldViewStatus = .inactive {
        didSet {
            switch status {
            case .active:
                inputContentContainerView.layer.borderColor = visual.activeBorderColor.cgColor
                titleLabel.textColor = visual.activeTitleColor
                errorLabel.isHidden = true
            case .inactive:
                inputContentContainerView.layer.borderColor = visual.inactiveBorderColor.cgColor
                titleLabel.textColor = visual.inactiveTitleColor
                errorLabel.isHidden = true
            case .error:
                inputContentContainerView.layer.borderColor = visual.errorBorderColor.cgColor
                titleLabel.textColor = visual.errorTitleColor
                errorLabel.isHidden = false
            }
        }
    }
    var title: String? {
        didSet{
            titleLabel.text = title
        }
    }
    var errorMessage: String? {
        didSet {
            errorLabel.text = errorMessage
        }
    }
    var inputKeyboardType: UIKeyboardType = .default {
        didSet {
            inputTextField.keyboardType = inputKeyboardType
        }
    }
    var placeholder: String? {
        didSet {
            inputTextField.placeholder = placeholder
        }
    }
    
    // IBInspectable
    @IBInspectable
    var localizePlaceholder: String? {
        didSet {
            placeholder = localizePlaceholder?.localized
        }
    }
    @IBInspectable
    var inputAble: Bool = false {
        didSet{
            inputTextField.isEnabled = inputAble
        }
    }
    @IBInspectable
    var enable: Bool = true {
        didSet{
            isUserInteractionEnabled = enable
        }
    }
    @IBInspectable
    var localizeTitle: String? {
        didSet{
            title = localizeTitle?.localized
        }
    }
    @IBInspectable
    var isRequired: Bool = false {
        didSet {
            requiredMaskLabel.isHidden = !isRequired
        }
    }
    @IBInspectable
    var value: String? {
        didSet {
            guard inputTextField.isEditing == false else { return }
            value = filter == nil ? value : filter?(value)
            let tempText = decorate == nil ? value : decorate?(value)
            inputTextField.text = tempText
            self.status = inputTextField.isEditing ?  .active : .inactive
        }
    }
    
    
    /// onTouchInputArea active only when inputAble  == false
    var onTapWholeArea: (()->Void)? {
        didSet {
            if !inputAble {
                tapGesture.isEnabled = true
            }
        }
    }
    
    var visual: InputFieldVisual = InputFieldView.defaultVisual {
        didSet {
            inputContentContainerView.layer.cornerRadius = visual.borderRadius
            inputContentContainerView.layer.borderWidth = visual.borderWidth
            let currentStatus = self.status
            self.status = currentStatus // apply new color for current status
        }
    }
    
    // MARK: - Public funcitons
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customInit()
    }
    
    func customInit() {
        // Init ContentStack
        contentStackView = UIStackView()
        contentStackView.axis = .vertical
        addSubview(contentStackView)
        contentStackView.snp.makeConstraints {
            $0.top.equalTo(10)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        inputContentContainerView = UIView()
        inputContentContainerView.setBorder(color: AppColor.inputBorderActive.color, width: 1, radius: AppSize.radius.size)
        contentStackView.addArrangedSubview(inputContentContainerView)
        inputContentContainerView.snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(40)
        }
        
        errorLabel =  UILabel()
        errorLabel.appTextStyle = AppTextStyle.small.textStyle
        errorLabel.textColor = AppColor.error.color
        contentStackView.addArrangedSubview(errorLabel)
        errorLabel.snp.makeConstraints {
            $0.height.equalTo(12)
        }
        errorLabel.isHidden = true
        contentStackView.addArrangedSubview(UIView()) // add empty view to dynamic height of bottom

        
        inputContentStackView = UIStackView()
        inputContentContainerView.addSubview(inputContentStackView)
        inputContentStackView.snp.makeConstraints {
            $0.left.equalTo(6)
            $0.right.equalTo(-4)
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        inputTextField = UITextField()
        inputTextField.delegate = self
        inputTextField.font = AppFont.regular(14).font
        inputContentStackView.addArrangedSubview(inputTextField)
        
        
        // Init title stackview
        let titleContentView = UIView()
        titleContentView.backgroundColor = .white
        addSubview(titleContentView)
        titleContentView.snp.makeConstraints {
            $0.top.equalTo(0)
            $0.left.equalTo(6)
            $0.height.equalTo(20)
        }
        titleStackView = UIStackView()
        titleStackView.spacing = 4
        titleContentView.addSubview(titleStackView)
        titleStackView.snp.makeConstraints {
            $0.left.equalTo(2)
            $0.right.equalTo(-2)
            $0.bottom.equalTo(0)
            $0.top.equalTo(0)
        }
        titleLabel = UILabel()
        titleLabel.appTextStyle = AppTextStyle.caption1.textStyle
        titleStackView.addArrangedSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(0)
            $0.bottom.equalTo(0)
        }
        requiredMaskLabel = UILabel()
        requiredMaskLabel.text = "*"
        requiredMaskLabel.appTextStyle = AppTextStyle.caption1.textStyle.with(font: AppFont.regular(12).font)
        requiredMaskLabel.isHidden = true
        requiredMaskLabel.textColor = AppColor.error.color
        titleStackView.addArrangedSubview(requiredMaskLabel)
        requiredMaskLabel.snp.makeConstraints {
            $0.width.equalTo(6) // This enought for content "*"
        }
        
        inputTextField.keyboardType = inputKeyboardType
        visual = InputFieldView.defaultVisual
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleWholeViewGesture))
        inputContentContainerView.addGestureRecognizer(tapGesture)
        tapGesture.isEnabled = false
    
    }
    
    // MARK: - Public funcitons
    // view SHOULD have self's width constraint
    @discardableResult
    func setRightView(view: UIView?) -> InputFieldView {
        if let rightView = rightView {
            inputContentStackView.removeArrangedSubview(rightView)
        }
        
        guard let view = view else {
            rightView = nil
            return self
        }
        rightView = view
        inputContentStackView.addArrangedSubview(view)
        return self
    }
    
    @discardableResult
    func setLeftView(view: UIView?) -> InputFieldView {
        if let leftView = leftView {
            inputContentStackView.removeArrangedSubview(leftView)
        }
        guard let view = view else {
            leftView = nil
            return self
        }
        leftView = view
        inputContentStackView.addArrangedSubview(view)
        return self
    }
    
    // MARK: - Private Functions
    @objc func handleWholeViewGesture() {
        onTapWholeArea?()
    }
}

extension InputFieldView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.status = .active
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.status = .inactive
        // call callback that value updated
        delegate?.inputFieldView(self, valueChanged: value)
        textChangedCallBack?(value)
        valueChangeSubject.onNext(value)

    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if restrictTexts.count > 0 {
            if restrictTexts.contains(string) {
                return false
            }            
        }
        let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            // add their new text to the existing text
        var updatedText: String? = currentText.replacingCharacters(in: stringRange, with: string)

        updatedText = filter == nil ? updatedText : filter?(updatedText)
        value = updatedText
        
        
        // decorate to get format output as required
        updatedText = decorate == nil ? updatedText : decorate?(updatedText)
        
        // set value back to textfield
        textField.text = updatedText
        return false
    }
}
