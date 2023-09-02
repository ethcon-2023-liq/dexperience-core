const HDWalletProvider = require('@truffle/hdwallet-provider');

const dotenv = require('dotenv');
dotenv.config();

const privateKey = process.env.DEPLOYER_WALLET_PRIVATEKEY;
const goerliNode = process.env.GOERLI_TESTNET_NODE_URI;
const maticNode = process.env.MATIC_TESTNET_NODE_URI;
const optimismNode = process.env.OPTIMISM_TESTNET_NODE_URI;

module.exports = {
  networks: {
    development: {
      host: "localhost",
      port: 7545,
      network_id: "5777"
    },
  },

  mocha: {
    // timeout: 100000
  },

  compilers: {
    solc: {
      version: "0.8.17",
      settings: {
        optimizer: {
          enabled: true,
          runs: 200
        }
      }
    }
  }
};
