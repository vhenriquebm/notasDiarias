//
//  AnotacaoViewController.swift
//  notasDiarias
//
//  Created by Vitor Henrique Barreiro Marinho on 08/02/22.
//

import UIKit
import CoreData

var context: NSManagedObjectContext!

class AnotacaoViewController: UIViewController {

    
    @IBAction func salvar(_ sender: Any) {
        
        salvarAnotacao()
        
        self.navigationController?.popViewController(animated: true)
        
        
    }
    
    func salvarAnotacao() {
        
        // cria objeto para anotacao
        let novaAnotacao = NSEntityDescription.insertNewObject(forEntityName: "Anotacao", into: context)
        
        //Configura o objeto
        novaAnotacao.setValue(self.texto.text, forKey: "texto")
        
        novaAnotacao.setValue(Date(), forKey: "data")
        
        
        do {
            try context.save()
            print("Sucesso ao salvar a anotação")
            
        } catch let erro as Error {
            print("Erro ao salvar anotação:" + erro.localizedDescription)
        }
        
        
        
        
    }
    
    
    @IBOutlet weak var texto: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.texto.becomeFirstResponder() // faz o teclado aparecer
        
        //Configurar campo texto
        self.texto.text = ""
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        context = appDelegate.persistentContainer.viewContext
        

    }
    
    
    
    
}

