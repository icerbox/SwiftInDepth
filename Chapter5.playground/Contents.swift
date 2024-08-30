import UIKit

enum Pawn: CaseIterable {
    case dog, car, ketchupBottle, iron, shoe, hat
}

struct Player {
    let name: String
    let pawn: Pawn
}

extension Player {
    init(name: String) {
        self.name = name
        self.pawn = Pawn.allCases.randomElement()!
    }
}
// Почленный инициализатор
let player = Player(name: "SuperJeff", pawn: .shoe)
let anotherPlayer = Player(name: "Mary", pawn: .dog)

// MARK: - Homework 5.1.3

struct Pancakes {

    enum SyrupType: CaseIterable {
        case corn
        case molasses
        case maple
    }

    let syrupType: SyrupType
    let stackSize: Int
}

extension Pancakes {
    init(syrupType: SyrupType) {
        self.syrupType = syrupType
        self.stackSize = Int.random(in: 10...100)
    }
}

let pancakes = Pancakes(syrupType: .corn, stackSize: 8)
let morePancakes = Pancakes(syrupType: .maple)

// 5.2 Инициализаторы и подклассы

//class BoardGame {
//    // Свойства
//    let players: [Player]
//    let numberOfTiles: Int
//
//    // Назначенный инициализатор
//    init(players: [Player], numberOfTiles: Int) {
//        self.players = players
//        self.numberOfTiles = numberOfTiles
//    }
//
//    // Вспомогательный инициализатор принимает игроков
//    convenience init(players: [Player]) {
//        self.init(players: players, numberOfTiles: 32)
//    }
//
//    // Вспомогательный инициализатор преобразует строки в игроков
//    convenience init(names: [String]) {
//        var players = [Player]()
//        for name in names {
//            players.append(Player(name: name))
//        }
//        self.init(players: players, numberOfTiles: 32)
//    }
//}

// Способы инициализации суперкласса BoardGame:

let boardGame = BoardGame(names: ["Melissa", "SuperJeff", "Dave"])

let players = [
    Player(name: "Melissa"),
    Player(name: "SuperJeff"),
    Player(name: "Dave")
]

let boardGame2 = BoardGame(players: players)

let boardGame3 = BoardGame(players: players, numberOfTiles: 32)

// MARK: - 5.2.3 Создание подкласса

//class MutabilityLand: BoardGame {
//    // ScoreBoard инициализируется с пустым словарем
//    var scoreBoard = [String: Int]()
//    var winner: Player?
//
//    // Новое свойство instructions
//    let instructions: String
//
//    init(players: [Player], instructions: String, numberOfTiles: Int) {
//        self.instructions = instructions
//        super.init(players: players, numberOfTiles: numberOfTiles)
//    }
//
//    // Новый назначенный инициализатор для инстанциирования инструкций
//    override init(players: [Player], numberOfTiles: Int) {
//        self.instructions = "Read the manual"
//        // Основной инициализатор вызывает инициализатор настольной игры
//        super.init(players: players, numberOfTiles: numberOfTiles)
//    }
//}

// Они больше не работают
//let mutabilityLand = MutabilityLand(names: ["Melissa", "SuperJeff", "Dave"])
//let mutabilityLand = MutabilityLand(players: players)
//let mutabilityLand = MutabilityLand(players: players, numberOfTiles: 32)

// MARK: - 5.2.5. Возвращение инициализаторов суперкласса

// Все доступные инициализаторы для MutabilityLand
//let mutabilityLand = MutabilityLand(players: players, instructions: "Just red the manual", numberOfTiles: 40)
//let mutabilityLand2 = MutabilityLand(players: players)
//let mutabilityLand3 = MutabilityLand(players: players, numberOfTiles: 32)

// MARK: - Homework 5.2.6
let firstTelevision = Television(room: "Lobby")
let secondTelevision = Television(serialNumber: "abc")

class Device {
    var serialNumber: String
    var room: String

    init(serialNumber: String, room: String) {
        self.serialNumber = serialNumber
        self.room = room
    }

    convenience init() {
        self.init(serialNumber: "Unknown", room: "Unknown")
    }

    convenience init(serialNumber: String) {
        self.init(serialNumber: serialNumber, room: "Unknown")
    }

    convenience init(room: String) {
        self.init(serialNumber: "Unknown", room: room)
    }
}

//class Television: Device {
//    enum ScreenType {
//        case led
//        case oled
//        case lcd
//        case unknown
//    }
//
//    enum Resolution {
//        case ultraHd
//        case fullHd
//        case hd
//        case sd
//        case unknown
//    }
//
//    let resolution: Resolution
//    let screenType: ScreenType
//
//    init(resolution: Resolution, screenType: ScreenType, serialNumber: String, room: String) {
//        self.resolution = resolution
//        self.screenType = screenType
//        super.init(serialNumber: serialNumber, room: room)
//    }
//
//    override init(serialNumber: String, room: String) {
//        self.resolution = .fullHd
//        self.screenType = .lcd
//        super.init(serialNumber: serialNumber, room: room)
//    }
//}

// MARK: - 5.3.1. Реализация назначенного инициализатора в качестве вспомогательного с использованием ключевого слова override

class MutabilityLand: BoardGame {
    // ScoreBoard инициализируется с пустым словарем
    var scoreBoard = [String: Int]()
    var winner: Player?

    // Новое свойство instructions
    let instructions: String

    // Теперь это переопределяющий вспомогательный инициализатор
    convenience required init(players: [Player], numberOfTiles: Int) {
        // Инициализатор теперь указывает в сторону (self.init), а не вверх (super.init)
        self.init(players: players, instructions: "Read the manual", numberOfTiles: numberOfTiles)
    }

    // Оставляем назначенный инициализатор как есть
    init(players: [Player], instructions: String, numberOfTiles: Int) {
        self.instructions = "Read the manual"
        // Основной инициализатор вызывает инициализатор настольной игры
        super.init(players: players, numberOfTiles: numberOfTiles)
    }
}

class MutabilityLandJunior: MutabilityLand {
    let soundsEnabled: Bool

    // MutabilityLandJunior получает собственный назначенный инициализатор
    init(soundsEnabled: Bool, players: [Player], instructions: String, numberOfTiles: Int) {
        self.soundsEnabled = soundsEnabled
        super.init(players: players, instructions: instructions, numberOfTiles: numberOfTiles)
    }

    // Добавлен единственный переопределяющий инициализатор
    convenience override init(players: [Player], instructions: String, numberOfTiles: Int) {
        self.init(soundsEnabled: false, players: players, instructions: instructions, numberOfTiles: numberOfTiles)
    }
}

// Теперь можно инициализировать эту игру пятью способами:
let mutabilityLandJr = MutabilityLandJunior(players: players, instructions: "Kids don't read manuals", numberOfTiles: 8)
let mutabilityLandJr2 = MutabilityLandJunior(soundsEnabled: true, players: players, instructions: "Kids don't read manuals", numberOfTiles: 8)
let mutabilityLandJr3 = MutabilityLand(names: ["Philippe", "Alex"])
let mutabilityLandJr4 = MutabilityLand(players: players)
let mutabilityLandJr5 = MutabilityLand(players: players, numberOfTiles: 8)

// MARK: - Homework 5.3.3
// Имеется класс, который делит подклассы Television из предыдущего упражнения.

class Television: Device {
    enum ScreenType {
        case led
        case oled
        case lcd
        case unknown
    }

    enum Resolution {
        case ultraHd
        case fullHd
        case hd
        case sd
        case unknown
    }

    let resolution: Resolution
    let screenType: ScreenType

    convenience override init(serialNumber: String, room: String) {
        self.init(serialNumber: serialNumber, room: room, resolution: .ultraHd, screenType: .lcd)

    }

    init(serialNumber: String, room: String, resolution: Resolution, screenType: ScreenType) {
        self.resolution = .fullHd
        self.screenType = .lcd
        super.init(serialNumber: serialNumber, room: room)
    }
}

class HandHeldTelevision: Television {
    let weight: Int

    init(weight: Int, resolution: Resolution, screenType: ScreenType, serialNumber: String, room: String) {
        self.weight = weight
        super.init(serialNumber: serialNumber, room: room, resolution: resolution, screenType: screenType)
    }

    convenience override init(serialNumber: String, room: String, resolution: Television.Resolution, screenType: Television.ScreenType) {
        self.init(weight: 90, resolution: .fullHd, screenType: .lcd, serialNumber: serialNumber, room: room)
    }

}

// Добавьте два вспомогательных инициализатора в иерархию подклассов, чтобы инициализатор работал из самого верхнего суперкласса
let handHeldTelevision = HandHeldTelevision(serialNumber: "293nr30znNdjW")

// MARK: - 5.4. Требуемые инициализаторы

// 5.4.1. Фабричные методы

//class BoardGame {
//    // Свойства
//    let players: [Player]
//    let numberOfTiles: Int
//
//    // Назначенный инициализатор
//    required init(players: [Player], numberOfTiles: Int) {
//        self.players = players
//        self.numberOfTiles = numberOfTiles
//    }
//
//    // Вспомогательный инициализатор принимает игроков
//    convenience init(players: [Player]) {
//        self.init(players: players, numberOfTiles: 32)
//    }
//
//    // Вспомогательный инициализатор преобразует строки в игроков
//    convenience init(names: [String]) {
//        var players = [Player]()
//        for name in names {
//            players.append(Player(name: name))
//        }
//        self.init(players: players, numberOfTiles: 32)
//    }
//
//    class func makeGame(players: [Player]) -> Self {
//        let boardGame = self.init(players: players, numberOfTiles: 32)
//        // Здесь идет конфигурация
//        // E.g.
//        // boardGame.locale = Locale.current
//        // boardGame.timeLimit = 900
//        return boardGame
//    }
//}

// 5.4.2. Протоколы

protocol BoardGameType {
    init(players: [Player], numberOfTiles: Int)
}

// Теперь это финальный класс
class BoardGame: BoardGameType {
    // Свойства
    let players: [Player]
    let numberOfTiles: Int

    // Использование ключевого слова required не требуется
    required init(players: [Player], numberOfTiles: Int) {
        self.players = players
        self.numberOfTiles = numberOfTiles
    }

    // Вспомогательный инициализатор принимает игроков
    convenience init(players: [Player]) {
        self.init(players: players, numberOfTiles: 32)
    }

    // Вспомогательный инициализатор преобразует строки в игроков
    convenience init(names: [String]) {
        var players = [Player]()
        for name in names {
            players.append(Player(name: name))
        }
        self.init(players: players, numberOfTiles: 32)
    }

    class func makeGame(players: [Player]) -> Self {
        let boardGame = self.init(players: players, numberOfTiles: 32)
        // Здесь идет конфигурация
        // E.g.
        // boardGame.locale = Locale.current
        // boardGame.timeLimit = 900
        return boardGame
    }
}

struct Point {
    var x: Double
    var y: Double
}

