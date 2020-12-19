//
//  NotesViewController.swift
//  NIT_08.12.2020
//
//  Created by Родион Сприкут on 08.12.2020.
//

import UIKit

protocol NotesViewControllerDelegate: AnyObject {
    func didEditNote(header: String, note: String)
    func didDeleteNote(noteIndex: Int)
}

class NotesViewController: UIViewController {
    
    var HEADER_KEY = ""
    var NOTE_KEY = ""
    var noteIndex = 0
    var didDeleteNote = false

    @IBOutlet weak var headerTextField: UITextField!
    @IBOutlet weak var noteTextField: UITextView!
    
    weak var delegate: NotesViewControllerDelegate?
    
    @IBAction func deleteNote(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: HEADER_KEY)
        UserDefaults.standard.removeObject(forKey: NOTE_KEY)
        didDeleteNote.toggle()
        noteTextField.text = "Заметка удалена"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerTextField.text = UserDefaults.standard.string(forKey: HEADER_KEY) ?? "Новая заметка"
        noteTextField.text = UserDefaults.standard.string(forKey: NOTE_KEY) ?? ""
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        if didDeleteNote {
            delegate?.didDeleteNote(noteIndex: noteIndex)
        } else {
            delegate?.didEditNote(header: headerTextField.text ?? "test", note: noteTextField.text ?? "test2")
        }
    }
}
