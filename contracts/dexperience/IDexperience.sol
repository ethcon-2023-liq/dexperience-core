// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

interface IDexperience {
    mapping(address => uint256) public balanceOf;
    mapping(address => uint256) public balanceOfToken;

    function depositETH() external payable;
    function depositERC20(address _token, uint256 _amount) external;
    function withdrawETH(address _to, uint256 _amount) external payable;
    function withdrawERC20(address _to, address _token, uint256 amount) external;
    function liquidate(uint256 _positionId) external;

    function getAccountValue(address _address) external view returns (uint256 total, uint256 available);

    function createPosition(uint256 _amount) external;
    function closePosition(uint256 _positionId) external;

    event DepositETH(address indexed from, uint256 amount);
    event DepositERC20(address indexed from, address token, uint256 amount);
    event WithdrawETH(address indexed from, address indexed to, uint256 amount);
    event WithdrawERC20(address indexed from, address indexed to, address token, uint256 amount);

    event CreatePosition(address indexed user, uint256 price, uint256 amount, uint256 positionId);
    event ClosePosition(address indexed user, uint256 price, uint256 amount, uint256 positionId);
    event liquidated(address indexed liquidator, uint256 positionId);
}
