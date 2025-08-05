// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";

contract monsterCard is ERC1155, Ownable, ERC1155Burnable { // Criar o contrato de MagicCard tambem, pensar em contrato que envolve conceitos de de-fi e aplicar ao jogo. Pensar em contrato de trapCard com privacidade (utxo)
    constructor(address initialOwner) ERC1155("") Ownable(initialOwner) {}

    mapping(uint256 id => MonsterAttributes) private monsterAttributesMap;
    mapping(uint256 id => mapping(bytes32 hashName => uint256 quantidade)) private monsterCardSupply;
    mapping(uint256 id => bool exists) private monsterCardExists;

    struct MonsterAttributes {
        uint256 attack;
        uint256 defense;
        uint256 life;
        uint256 mana;
        bytes32 hashName;
    }
    
    function createMonsterCard(MonsterAttributes memory monsterAttributes, uint256 id, uint256 amount, bytes memory data) public onlyOwner {
        require(monsterAttributes.hashName != bytes32(0), "Monster name hash cannot be zero");
        require(monsterCardSupply[id][monsterAttributes.hashName] == 0, "Monster card with this name already exists");
        require(!monsterCardExists[id], "Monster card with this ID already exists");
        
        monsterAttributesMap[id] = monsterAttributes;
        _mint(account, id, amount, data); 
        
        monsterCardSupply[id][monsterAttributes.hashName] = amount;
        monsterCardExists[id] = true;
    }

    function getMonsterAttributes(uint256 id) public view returns (MonsterAttributes memory) {
        return monsterAttributesMap[id];
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
