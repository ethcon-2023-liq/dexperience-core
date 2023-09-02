// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "../common/token/ERC20/IERC20.sol";
import "./IDexperience.sol";

contract Dexperience is IDexperience {
    constructor(string memory _name, string memory _symbol, uint8 _decimals) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
    }

    function depositETH() override external payable {
        balanceOf[msg.sender] = balanceOf[msg.sender] + msg.value;
        emit DepositETH(msg.sender, msg.value);
    }

    function depositERC20(address _token, uint256 _amount) override external {
        IERC20(_token).transferFrom(msg.sender, address(this), _amount);
        balanceOfToken[_token][msg.sender] = balanceOfToken[_token][msg.sender] + _amount;
        emit DepositERC20(msg.sender, _token, _amount);
    }

    function withdrawETH(address _to, uint256 amount) override external payable {
        balanceOf[msg.sender] = balanceOf[msg.sender] - amount;
        payable(_to).transfer(amount);
        emit WithdrawETH(msg.sender, _to, amount);
    }

    function withdrawERC20(address _to, address _token, uint256 amount) override external {
        balanceOfToken[_token][msg.sender] = balanceOfToken[_token][msg.sender] - amount;
        IERC20(_token).transfer(_to, amount);
        emit WithdrawERC20(msg.sender, _to, _token, amount);
    }

    function liquidate(uint256 _positionId) external payable {
        emit liquidated(msg.sender, address(this), _positionId);
    }

    function getAccountValue(address _address) external view returns (uint256, uint256) {};
}
