//
//  ViewController.swift
//  NIT_08.12.2020
//
//  Created by Родион Сприкут on 08.12.2020.
//

import UIKit

struct NoteExample {
    var header: String
    var note: String
}

class ViewController: UIViewController {
    let NOTES_COUNT_KEY = "Number_of_notes"
    
    let headerKeyExample = "HEADER_KEY_"
    let noteKeyExample = "TEXT_KEY_"
    var HEADER_KEYS: [String] = []
    var NOTE_KEYS: [String] = []
    
    var numberOfNotes = 1
    
    var noteIndex = 0

    @IBOutlet weak var notesTableView: UITableView!
    

    @IBAction func addNoteButton(_ sender: Any) {
        numberOfNotes += 1
        UserDefaults.standard.setValue(numberOfNotes, forKey: NOTES_COUNT_KEY)
        notesTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberOfNotes = UserDefaults.standard.integer(forKey: NOTES_COUNT_KEY)
        UserDefaults.standard.setValue(numberOfNotes, forKey: NOTES_COUNT_KEY)
        
        notesTableView.dataSource = self
        notesTableView.delegate = self
        notesTableView.register(UINib(nibName: "CustomViewCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        UserDefaults.standard.integer(forKey: NOTES_COUNT_KEY)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = notesTableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomViewCell
        

        if HEADER_KEYS.count == indexPath.row {
            HEADER_KEYS.append("\(headerKeyExample)\(indexPath.row)")
            NOTE_KEYS.append("\(noteKeyExample)\(indexPath.row)")
        }

        cell.cellHeaderLabel.text = UserDefaults.standard.string(forKey: HEADER_KEYS[indexPath.row]) ?? "Новая заметка"

        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: "NotesViewController") as! NotesViewController
        controller.delegate = self
        
        noteIndex = indexPath.row
        
        controller.HEADER_KEY = HEADER_KEYS[indexPath.row]
        controller.NOTE_KEY = NOTE_KEYS[indexPath.row]

        self.navigationController!.pushViewController(controller, animated: true)
    }
}

extension ViewController: NotesViewControllerDelegate {
    func didEditNote(header: String, note: String) {
        UserDefaults.standard.setValue(header, forKey: HEADER_KEYS[noteIndex])
        UserDefaults.standard.setValue(note, forKey: NOTE_KEYS[noteIndex])
        notesTableView.reloadData()
    }
    
    func didDeleteNote(noteIndex: Int) {
        numberOfNotes -= 1
        
        var headersArray: [String] = []
        var notesArray: [String] = []
        
        for i in 0..<HEADER_KEYS.count {
            if i < noteIndex {
                headersArray.append(HEADER_KEYS[i])
                notesArray.append(NOTE_KEYS[i])
            } else if i == noteIndex {
                continue
            } else {
                HEADER_KEYS[i] = "\(headerKeyExample)\(noteIndex - 1)"
                NOTE_KEYS[i] = "\(noteKeyExample)\(noteIndex - 1)"
                headersArray.append(HEADER_KEYS[i])
                notesArray.append(NOTE_KEYS[i])
                
            }
        }
        HEADER_KEYS = headersArray
        NOTE_KEYS = notesArray
        print(HEADER_KEYS.count)
        notesTableView.reloadData()
    }
}
