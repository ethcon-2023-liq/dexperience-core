// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

interface IDexperience {
    mapping(address => uint) public balanceOf;
    mapping(address => mapping(address => uint256)) public balanceOfToken;
    string[] public exchangePositions;

    function depositETH() external payable;
    function depositERC20(address _token, uint256 _amount) external payable;
    function withdrawETH(address _to, uint256 _amount) external payable;
    function withdrawERC20(address _to, address _token, uint256 amount) external payable;
    function liquidate(uint256 _positionId) external payable;

    function getAccountValue(address _address) external view returns (uint256 total, uint256 available);

    event DepositETH(address indexed _from, uint256 _value);
    event DepositERC20(address indexed _from, address _token, uint256 _value);
    event WithdrawETH(address indexed _from, address indexed _to, uint256 _value);
    event WithdrawERC20(address indexed _from, address indexed _to, address _token, uint256 _value);

    event trade(address indexed _user, address indexed _exchange, uint256 _positionId);
    event liquidated(address indexed _liquidator, address indexed _exchange, uint256 _positionId);
}
