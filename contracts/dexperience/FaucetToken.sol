// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "../common/token/ERC20/IERC20.sol";

contract FaucetToken is IERC20 {
    uint public totalSupply;
    mapping(address => uint) public balanceOf;
    mapping(address => mapping(address => uint)) public allowance;
    string public name;
    string public symbol;
    uint8 public decimals;

    constructor(string memory _name, string memory _symbol, uint8 _decimals) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
    }

    function transfer(address recipient, uint amount) external returns (bool) {
        balanceOf[msg.sender] = balanceOf[msg.sender] - amount;
        balanceOf[recipient] = balanceOf[recipient] + amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    function approve(address spender, uint amount) external returns (bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool) {
        allowance[sender][msg.sender] = allowance[sender][msg.sender] - amount;
        balanceOf[sender] = balanceOf[sender] - amount;
        balanceOf[recipient] = balanceOf[recipient] + amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }

    function mint(uint amount) external {
        address account = msg.sender;
        balanceOf[account] = balanceOf[account] + amount;
        totalSupply = totalSupply + amount;
        emit Transfer(address(0), account, amount);
    }
}
