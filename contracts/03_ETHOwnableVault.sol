// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {IETHOwanableVault} from "./03_IETHOwnableVault.sol";

contract ETHOwanableVault is IETHOwanableVault {
    address public owner;

    constructor(address _owner) {
        owner = _owner;

        // Podríamos NO recibir la address por parámetro
        // y definir owner = msg.sender
        // El owner sería la address que deploya el contrato
    }

    function deposit(uint256 amount) public payable {
        require(amount == msg.value, "Cantidades diferentes");
        if (msg.value == 0) revert ZeroDeposit();
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw() public onlyOwner {
        uint256 amountToSend = address(this).balance;
        (bool sent, bytes memory data) = owner.call{value: amountToSend}("");
        emit Withdraw(owner, amountToSend);
    }

    modifier onlyOwner() {
        if (msg.sender != owner) revert NotOwner();
        _;
    }

    modifier onlyOwner2(address _owner) {
        if (_owner != owner) revert NotOwner();
        _;
    }
}
