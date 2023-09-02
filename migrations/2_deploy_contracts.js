const FaucetToken = artifacts.require("FaucetToken");

module.exports = function (deployer) {
    deployer.deploy(FaucetToken, "USD Coin", "USDC", 18);
    deployer.deploy(FaucetToken, "Chainlink Token", "LINK", 18);
};
