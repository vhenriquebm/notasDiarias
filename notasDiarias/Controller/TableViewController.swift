//
//  TableViewController.swift
//  notasDiarias
//
//  Created by Vitor Henrique Barreiro Marinho on 08/02/22.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
        
    var context: NSManagedObjectContext!
    // Para recuperar a anotação você precisa de um array do tipo NSManagedObject
    var anotacoes: [NSManagedObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        context = appDelegate.persistentContainer.viewContext
    }

    
    override func viewDidAppear(_ animated: Bool) {
        recuperarAnotacoes()
    }
    
    func recuperarAnotacoes () {
        
        let requisicao = NSFetchRequest<NSFetchRequestResult>(entityName: "Anotacao")
        
        
        do {
            
           let anotacoesRecuperadas =  try context.fetch(requisicao)
            self.anotacoes = anotacoesRecuperadas as! [NSManagedObject]
            self.tableView.reloadData()

            print ("Dados recuperados com sucesso")
        } catch let erro as Error {
            print("Erro ao recuperar as anotações \(erro.localizedDescription)")
        }
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.anotacoes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let celula = tableView.dequeueReusableCell(withIdentifier: "celula", for: indexPath)
        
        let anotacao = self.anotacoes[indexPath.row]
        
        let textoRecuperado = anotacao.value(forKey:"texto")
        let dataRecuperada = anotacao.value(forKey: "data")
        
        // formatar data, pois esta padrão americano e como optional
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let novaData = dateFormatter.string(from: dataRecuperada as! Date)
        
        celula.textLabel?.text = textoRecuperado as? String // ele é do tipo any e convertemos em String
        celula.detailTextLabel?.text = novaData
        
        return celula
    }




}
