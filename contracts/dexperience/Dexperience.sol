// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "../common/token/ERC20/IERC20.sol";
import "./IDexperience.sol";
import "./AggregatorV3Interface.sol";

contract Dexperience is IDexperience {
    AggregatorV3Interface internal dataFeed;
    address public usdcAddress;

    constructor(address _ethOracle, address _usdc) {
        dataFeed = AggregatorV3Interface(_ethOracle);
        usdcAddress = _usdc;
    }

    function depositETH() override external payable {
        balanceOf[msg.sender] = balanceOf[msg.sender] + msg.value;
        emit DepositETH(msg.sender, msg.value);
    }

    function depositERC20(address _token, uint256 _amount) override external {
        IERC20(_token).transferFrom(msg.sender, address(this), _amount);
        balanceOfToken[msg.sender] = balanceOfToken[msg.sender] + _amount;
        emit DepositERC20(msg.sender, _token, _amount);
    }

    function withdrawETH(address _to, uint256 amount) override external payable {
        (uint256 total, uint256 available) = _getAccountValue(msg.sender);
        Position memory position = positions[_address];
        uint256 notional = position.amount * _getEthPrice() / 10 ** 8;
        require(notional < (total - balanceOf[msg.sender] * _getEthPrice() / 10 ** 8) * 15, "Not enough collateral");

        balanceOf[msg.sender] = balanceOf[msg.sender] - amount;
        payable(_to).transfer(amount);
        emit WithdrawETH(msg.sender, _to, amount);
    }

    function withdrawERC20(address _to, address _token, uint256 amount) override external {
        (uint256 total, uint256 available) = _getAccountValue(msg.sender);
        Position memory position = positions[_address];
        uint256 notional = position.amount * _getEthPrice() / 10 ** 8;
        require(notional < (total - balanceOfToken[msg.sender]) * 15, "Not enough collateral");

        balanceOfToken[msg.sender] = balanceOfToken[msg.sender] - amount;
        IERC20(_token).transfer(_to, amount);
        emit WithdrawERC20(msg.sender, _to, _token, amount);
    }

    function liquidate(address _address) external {
        (uint256 total, uint256 available) = _getAccountValue(msg.sender);
        Position memory position = positions[_address];
        uint256 notional = position.amount * _getEthPrice() / 10 ** 8;
        require(notional < total * 15, "Not enough collateral");
        _closePosition(_address);
    }

    struct Position {
        int price;
        uint256 amount;
        bool alive;
    }

    mapping(address => Position) public positions;

    function createPosition(uint256 _amount) external {
        int ethPrice = _getEthPrice();
        (uint256 total, uint256 available) = _getAccountValue(msg.sender);
        uint256 notional = _amount * _getEthPrice() / 10 ** 8;
        require(notional < total * 15, "Not enough collateral");

        Position storage position = positions[msg.sender];
        position = Position(ethPrice, _amount, true);
    }

    function closePosition(address _address) override external {
        Position memory position = positions[_address];
        require(position.alive, "Position is not alive");
        require(_address == msg.sender, "Only owner can close position");
        _closePosition(_address);
    }

    function _closePosition(address _address) private {
        int ethPrice = _getEthPrice();
        Position storage position = positions[_address];

        if (position.price <= ethPrice) {
            balanceOfToken[_address] = balanceOfToken[_address] + (ethPrice - position.price) * position.amount / 10 ** 8;
        } else {
            balanceOfToken[_address] = balanceOfToken[_address] - (position.price - ethPrice) * position.amount / 10 ** 8;
        }

        position.alive = false;
        position.amount = 0;
        position.price = 0;
    }

    function getAccountValue(address _address) external view returns (uint256, uint256) {
        return _getAccountValue(_address);
    }

    function _getAccountValue(address _address) private view returns (uint256, uint256) {
        uint256 ethValue = balanceOf[_address] * _getEthPrice() / 10 ** 8;
        uint256 tokenValue = balanceOfToken[_address];
        Position memory position = positions[_address];
        uint256 lockedCollateral = position.amount * ethValue / 10 ** 8 / 15;
        return (ethValue + tokenValue, ethValue + tokenValue - lockedCollateral);
    }

    function _getEthPrice() private view returns (int) {
        (
            int answer,
        ) = dataFeed.lastRoundData();
        return answer;
    }
}
