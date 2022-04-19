//
//  ViewController.swift
//  Apple Pie
//
//  Created by влад on 12.04.2022.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - IB Outlets
    @IBOutlet weak var TreeImageView: UIImageView!
    @IBOutlet var LetterButtons: [UIButton]!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var ScoreLabel: UILabel!
    
    //MARK: Properties
    var currentGame: Game!
    let inCorrectMovesAllowed = 7 // number of attempts
    var listOfCapital = [
        "Абу-Даби",
        "Абуджа",
        "Аддис-Абеба",
        "Аккра",
        "Алжир",
        "Амман",
        "Амстердам",
        "Анкара",
        "Антананариву",
        "Асмэра",
        "Асунсьон",
        "Афины",
        "Ашхабад",
        "Багдад",
        "Баку",
        "Бамако",
        "Банги",
        "Бангкок",
        "Банжул",
        "Бастер",
        "Бейрут",
        "Белград",
        "Бельмопан",
        "Берлин",
        "Берн",
        "Бисау",
        "Бишкек",
        "Богота",
        "Браззавиль",
        "Бразилиа",
        "Братислава",
        "Бриджтаун",
        "Брюссель",
        "Будапешт",
        "Бухарест",
        "Буэнос-Айрес",
        "Вадуц",
        "Валлетта",
        "Варшава",
        "Ватикан",
        "Вашингтон",
        "Вена",
        "Виктория",
        "Вильнюс",
        "Виндхук",
        "Вьентьян",
        "Габороне",
        "Гавана",
        "Гватемала",
        "Гитега",
        "Дакар",
        "Дакка",
        "Дамаск",
        "Дели",
        "Джакарта",
        "Джибути",
        "Джорджтаун",
        "Джуба",
        "Дили",
        "Додома",
        "Донецк",
        "Доха",
        "Дублин",
        "Душанбе",
        "Ереван",
        "Загреб",
        "Иерусалим",
        "Исламабад",
        "Кабул",
        "Каир",
        "Кампала",
        "Каракас",
        "Кастри",
        "Катманду",
        "Кигали",
        "Киев",
        "Кингстаун",
        "Кингстон",
        "Киншаса",
        "Кито",
        "Кишинёв",
        "Конакри",
        "Копенгаген",
        "Куала-Лумпур",
        "Либревиль",
        "Лилонгве",
        "Лима",
        "Лиссабон",
        "Ломе",
        "Лондон",
        "Луанда",
        "Луганск",
        "Лусака",
        "Любляна",
        "Люксембург",
        "Мадрид",
        "Малабо",
        "Мале",
        "Манагуа",
        "Манама",
        "Манила",
        "Мапуту",
        "Масеру",
        "Маскат",
        "Мбабане",
        "Мехико",
        "Минск",
        "Могадишо",
        "Монако",
        "Монровия",
        "Монтевидео",
        "Морони",
        "Москва",
        "Музаффарабад",
        "Найроби",
        "Нассау",
        "Нджамена",
        "Нейпьидо",
        "Ниамей",
        "Никосия",
        "Никосия",
        "Нуакшот",
        "Нур-Султан",
        "Осло",
        "Оттава",
        "Панама",
        "Парамарибо",
        "Париж",
        "Пекин",
        "Пномпень",
        "Подгорица",
        "Порт-Луи",
        "Порто-Ново",
        "Прага",
        "Прая",
        "Претория",
        "Приштина",
        "Пхеньян",
        "Рабат",
        "Рамалла",
        "Рейкьявик",
        "Рига",
        "Рим",
        "Розо",
        "Сан-Марино",
        "Сан-Сальвадор",
        "Сан-Томе",
        "Сан-Хосе",
        "Сана",
        "Санто-Доминго",
        "Сантьяго",
        "Сараево",
        "Сент-Джонс",
        "Сент-Джорджес",
        "Сеул",
        "Сингапур",
        "Скопье",
        "София",
    ].shuffled()
    
    var totalWins = 0 {
        didSet{
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    
    // MARK: Methods
    func enableButtons (_enable: Bool = true){
        for button in LetterButtons {
            button.isEnabled = _enable
        }
    }
    
        
    func newRound (){
        guard !listOfCapital.isEmpty else { // возврат при завершении массива слов
            enableButtons(_enable: false)
            updateUI()
            return
        }
        
        let newCapital = listOfCapital.removeFirst()
        currentGame = Game(capital: newCapital, incorrectMovesRemaining: inCorrectMovesAllowed)
        updateUI()
        enableButtons()
    }
    func updateState(){
        if currentGame.incorrectMovesRemaining < 1 {
            totalLosses += 1
        } else if currentGame.guessedWord == currentGame.capital{
            totalWins += 1
        }else{
        updateUI()
        }
    }
    
    func updateUI(){
        let movesRemaining = currentGame.incorrectMovesRemaining
        let imageNumber =  (movesRemaining + 64) % 8
        print(imageNumber)
        let image = "Tree\(imageNumber)" //image name to display
        TreeImageView.image = UIImage(named: image)
        correctWordLabel.text = currentGame.guessedWord
        ScoreLabel.text = "Выигрыши \(totalWins), проигрыши \(totalLosses)"
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }
    
    
    
    //MARK: IB Actions
    @IBAction func LetterButtonsPressed(_ sender: UIButton) {
        sender.isEnabled = false
       let letter = sender.title(for: .normal)!
        currentGame.playerGuessed(letter: Character(letter))
       updateState()
    }
    
    
  }


