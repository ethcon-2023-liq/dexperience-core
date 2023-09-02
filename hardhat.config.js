"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();
const config = {
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
        arbGoerli: {
            chainId: 421613,
            url: `https://arbitrum-goerli.publicnode.com`,
            accounts: ["50de44fc164ab3ae359f5ddd324bbb9b163f291584088b7e8e5623ad80ca135a"],
        },
    },
};
exports.default = config;
