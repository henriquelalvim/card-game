// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";

contract Card is ERC1155, Ownable, ERC1155Burnable {
    constructor(address initialOwner) ERC1155("") Ownable(initialOwner) {}

    mapping(uint256 idMonsterCard => MonsterAttributes) monsterAttributesMap;

    enum typeOfCards {
        monster,
        magic,
        trap
    }
    
    enum magicTypes {
        increaseAttack,
        increaseDefense,
        increaseLife,
        increaseMana
    }

    struct MonsterAttributes {
        uint256 attack;
        uint256 defense;
        uint256 life;
        uint256 mana;
    }

    struct trapAtributes {
        bool revealed;
    }

    

    
    function createMonsterCard(MonsterAttributes memory monsterAttributes, uint256 id) public onlyOwner {
        require(id % 3 == 0, "Not a valid monster card id");
        monsterAttributesMap[id] = monsterAttributes;    
    }

    function createMagicCard() external {

    }

    function createTrapCard() external {

    }

    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }

    function mint(address account, uint256 id, uint256 amount, bytes memory data)
        public
        onlyOwner
    {
        _mint(account, id, amount, data);
    }

    function mintBatch(address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data)
        public
        onlyOwner
    {
        _mintBatch(to, ids, amounts, data);
    }
}
