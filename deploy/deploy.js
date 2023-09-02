"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const hardhat_1 = require("hardhat");
//feeRatio is BP, 30 is equal to 0.3%
async function deployBridgeOnEth(validator, feeRatio) {
    //const [signer] = await ethers.getSigners();
    const bridgeFactory = await hardhat_1.ethers.getContractFactory("Bridge");
    const bridgeContract = await bridgeFactory.deploy(validator, feeRatio, true);
    await bridgeContract.deployed();
    console.log(bridgeContract.address);
    await bridgeContract.addSupportedChainId(56);
}
async function deployBridgeOnBsc(validator, feeRatio) {
    //const [signer] = await ethers.getSigners();
    const bridgeFactory = await hardhat_1.ethers.getContractFactory("Bridge");
    const bridgeContract = await bridgeFactory.deploy(validator, feeRatio, false);
    await bridgeContract.deployed();
    console.log(bridgeContract.address);
    await bridgeContract.addSupportedChainId(1);
}
async function addSupportedTokenToBridge(bridgeAddress, tokenAddress) {
    const bridgeContract = await hardhat_1.ethers.getContractAt("Bridge", bridgeAddress);
    await bridgeContract.addSupportedToken(tokenAddress);
}
async function deployToken(name, symbol, decimals, bridgeAddress) {
    const tokenFactory = await hardhat_1.ethers.getContractFactory("Token");
    const tokenContract = await tokenFactory.deploy(name, symbol, decimals);
    await tokenContract.deployed();
    console.log(tokenContract.address);
    await tokenContract.addMintableAddress(bridgeAddress);
}
//WBNB: 0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c
async function deployFactory() {
    const [signer] = await hardhat_1.ethers.getSigners();
    const factory = await hardhat_1.ethers.getContractFactory("UniswapV2Factory");
    const factoryContract = await factory.deploy(signer.address, signer.address);
    await factoryContract.deployed();
    console.log(factoryContract.address);
    console.log(await factoryContract.PAIR_HASH());
}
//should update init code hash of pairFor function in UniswapV2Library.sol same as PAIR_HASH of factory
async function deployRouter(WBNBAddress, factoryAddress) {
    const routerFactory = await hardhat_1.ethers.getContractFactory("UniswapV2Router");
    const routerContract = await routerFactory.deploy(factoryAddress, WBNBAddress);
    await routerContract.deployed();
    console.log(routerContract.address);
}
async function createPair(token0Address, token1Address, factoryAddress) {
    const factoryContract = await hardhat_1.ethers.getContractAt("UniswapV2Factory", factoryAddress);
    await factoryContract.createPair(token0Address, token1Address);
}
async function main() {
}
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
