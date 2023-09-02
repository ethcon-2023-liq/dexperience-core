import { ethers } from 'hardhat';
import * as dotenv from 'dotenv';
dotenv.config();

async function deployDexperience() {
  const ethOracle = process.env.ETH_ORACLE;
  const usdcAddress = process.env.USDC_ADDRESS;
  const [signer] = await ethers.getSigners();
  const dexperienceFactory = await ethers.getContractFactory("Dexperience");
  const dexperienceContract = await dexperienceFactory.deploy(ethOracle, usdcAddress);
  await dexperienceContract.deployed();
  console.log(dexperienceContract.address);
}

async function main() {
  await deployDexperience();
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
