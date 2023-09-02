import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

require("dotenv").config();

const config: HardhatUserConfig = {
  solidity: {
    version: "0.8.4",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
  networks: {
    localhost: {},
    mumbai: {
      chainId: 80001,
      url: `https://polygon-mumbai.blockpi.network/v1/rpc/public`,
      accounts: [process.env.PRIVATE_KEY!!],
    },
    optimismGoerli: {
      chainId: 420,
      url: `https://endpoints.omniatech.io/v1/op/goerli/public`,
      accounts: [process.env.PRIVATE_KEY!!],
    },
  },
};

export default config;
