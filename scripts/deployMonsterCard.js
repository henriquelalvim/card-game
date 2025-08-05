// scripts/deploy.js
const hre = require("hardhat");

async function main() {
    // Define the initial owner address - you can use any account address or the deployer’s address
    const [deployer] = await hre.ethers.getSigners();

    console.log("Deploying contracts with the account:", deployer.address);

    // Deploy the Card contract
    const Card = await hre.ethers.getContractFactory("Card");
    
    // Set the initial owner address (the deployer in this case)
    const initialOwner = deployer.address;
    
    const card = await Card.deploy(initialOwner);
    await card.waitForDeployment();

    console.log("Card contract deployed to:", card.target);
}

// Execute the deployment script, handling errors
main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });