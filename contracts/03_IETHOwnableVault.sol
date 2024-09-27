// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

interface IETHOwanableVault {
    error NotOwner();
    error ZeroDeposit();

    event Deposit(address sender, uint256 amount);
    event Withdraw(address owner, uint256 amount);

    function deposit(uint256 amount) external payable;

    function withdraw() external;

    function owner() external returns (address);
}
