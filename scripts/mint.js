// scripts/mint.js
const hre = require("hardhat");

async function main() {
    // Recupera as contas disponíveis
    const [deployer] = await hre.ethers.getSigners();

    console.log("Minting tokens with the account:", deployer.address);

    // Substitua pelo endereço do contrato implantado
    const cardAddress = "0xe7f1725e7734ce288f8367e1bb143e90bb3f0512"; // Insira o endereço do seu contrato
    const Card = await hre.ethers.getContractAt("Card", cardAddress);

    // Defina os parâmetros para mintar
    const recipient = deployer.address; // Endereço que receberá o token
    const tokenId = 1; // ID do token a ser mintado (você pode escolher um ID que você preferir)
    const amount = 5; // Quantidade de tokens a serem mintados
    const data = "0x"; // Dados adicionais

    // Mint o token
    const tx = await Card.mint(recipient, tokenId, amount, data);
    console.log("Minting...");

    // Aguarde a transação ser minerada
    await tx.wait();

    console.log(`${amount} token(s) with ID ${tokenId} minted to ${recipient}`);

    // Chama a função balanceOf do contrato
    const balance = await Card.balanceOf(deployer.address, tokenId);
    
    console.log(`Balance of token ID ${tokenId} for ${deployer.address}: ${balance.toString()}`);
}


// Executa o script de mint, tratando erros
main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });