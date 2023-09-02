# Dexperience Core
## ERC-4337
An account abstraction proposal which completely avoids the need for consensus-layer protocol changes. Instead of adding new protocol features and changing the bottom-layer transaction type, this proposal introduces a higher-layer pseudo-transaction object called a UserOperation. Users send UserOperation objects into a new separate mempool. Bundlers package up a set of these objects into a single transaction by making a call to a special contract, and that transaction then gets included in a block.

## Paymaster & Bundlers
Dexperience uses Biconomy system to provide great experience of Account abstraction and Meta transactions.
* Check this out: https://www.biconomy.io/ <br/>

## Dexperience Functions
* depositETH()
* depositERC20(token, amount)
* withdrawETH(amount)
* withdrawERC20(token, amount)
* createPosition(amount)
* closePosition(address)
* position(address)
* liquidate(address)

Currently, user can have only one position in ETH/USD pair. Multiple positions and Various trading pairs will be supported in the future.

## Oracle Price Addr
Dexperience uses chainlink price feeds for evaluating values of collaterals. The following are the addresses of the price feeds used in the different networks.
### Matic Mumbai
* ETH/USD: 0x0715A7794a1dc8e42615F059dD6e406A6594651A
### OP Goerli
* ETH/USD: 0x57241A37733983F97C4Ab06448F244A1E0Ca0ba8

## Liquidation
Can be called by anyone. If the condition meets, the position will be liquidated. Liquidators can gain 0.1% of the notional value of the position. This job is registered in [Chainlink Automation](https://automation.chain.link/).