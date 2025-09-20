GameManager
├── Game (живет всё время работы приложения)
│    ├── characterIds (выбранные персонажи для игры)
│    └── matches [Match] (список матчей, даже пустых)
│
└── MatchManager (управляет текущим матчем)
├── Match
│    ├── battleIds [Battle] (список баттлов)
│    └── createdAt
│
└── BattleManager (управляет текущим баттлом)
├── Battle
│    ├── characterNames [String, String] (фиксируем имена на момент баттла)
│    ├── scores [Score] (каждое очко)
│    └── finished (true/false)
│
└── Score
├── id
├── value (номер очка в баттле)
└── characterId (кто взял очко)


⚙ Поток данных
Welcome Board

CharacterManager → список глобальных персонажей.

Игроки выбираются → создаётся Game (если ещё нет).

При нажатии «Играть» → создаётся новый Match и сразу сохраняется в Game.matches.

Match Board

MatchManager создаёт первый Battle.

Каждое нажатие кнопки «+ очко» → BattleManager.addScore(characterId).

BattleManager добавляет Score в список, пересчитывает счёт.

Если один из игроков набрал 21 → Battle помечается завершённым, создаётся новый Battle в этом же Match.

UI (табличная верстка 4/4)

1a+1b → текущий счёт баттла (char1: 15 – char2: 12).

2a → история текущего баттла (список очков: чар2, чар1, чар2…).

2b → история матча (список завершённых баттлов: «Баттл 1: 21–18», «Баттл 2: 19–21»).

📌 Принципы
GameManager — владелец всей игровой сессии.

MatchManager — владелец текущего матча.

BattleManager — владелец текущего баттла.

Score — атомарное событие, не меняется после создания.

История всегда хранится в сущностях (Game.matches, Match.battles, Battle.scores), UI только подписывается на изменения.

