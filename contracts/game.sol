// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

MonsterCard {
    struct MonsterAttributes {
        uint256 attack;
        uint256 defense;
        uint256 life;
        uint256 mana;
    }

    function getMonsterAttributes(uint256 id) external view returns (MonsterAttributes memory);
}

contract game {// TODO: tornar o jogo mais complexo, adicionar mais funcionalidades, como turnos, ações, etc. Tornar partida apostavel em ether, usar conceitos de de-fi, acrescentar cartas de magica

    MonsterCard public monsterCard;
    address public monsterCard;
    constructor(address monsterCardAddress) {
        monsterCard = MonsterCard(monsterCardAddress);
    }    

    enum gameState { WaitingForPlayers, InProgress, Finished, Canceled }

    mapping(uint256 => address[2]) public players;
    mapping(uint256 => gameState) public gameStates;
    uint256 public gameId = 1;

    initiateGame() public {
        players[gameId][0] = msg.sender;
        gameId++;
    }

    function joinGame(uint256 gameId) public {
        require(players[gameId][1] == address(0), "Game already has two players");
        require(players[gameId][0] != msg.sender, "You cannot join your own game");
        require(gameStates[gameId] == gameState.WaitingForPlayers, "Game is not in waiting state");
        players[gameId][1] = msg.sender;
        
        startGame(gameId);
    }

    function startGame(uint256 gameId) private {
        gameStates[gameId] = gameState.InProgress;
    }

    function getGameState(uint256 gameId) public view returns (gameState) {
        return gameStates[gameId];
    }

    function getPlayers(uint256 gameId) public view returns (address[2] memory) {
        return players[gameId];
    }

    function playFirstHandPlayerOne(uint256 gameId, uint256[] memory cardsId) public {
        require(gameStates[gameId] == gameState.InProgress, "Game is not in progress");
        require(players[gameId][0] == msg.sender, "You are not player 1 in this game");

        // Logic to play the card
        MonsterCard.MonsterAttributes memory attributes = monsterCard.getMonsterAttributes(cardId);
            // Use attributes to determine game logic
    }

    playFirstHandPlayerTwo(uint256 gameId, uint256[] memory cardsId) public {
        require(gameStates[gameId] == gameState.InProgress, "Game is not in progress");
        require(players[gameId][1] == msg.sender, "You are not player 2 in this game");

        // Logic to play the card
        MonsterCard.MonsterAttributes memory attributes = monsterCard.getMonsterAttributes(cardId);
            // Use attributes to determine game logic
    }

    function playCard(uint256 gameId, uint256 cardId) public {
        require(gameStates[gameId] == gameState.InProgress, "Game is not in progress");
        require(players[gameId][0] == msg.sender || players[gameId][1] == msg.sender, "You are not a player in this game");

        // Logic to play the card
        MonsterCard.MonsterAttributes memory attributes = monsterCard.getMonsterAttributes(cardId);
            // Use attributes to determine game logic
    }

    function endGame(uint256 gameId) public {
        // Logic to end the game
    }
}