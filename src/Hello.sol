// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol"; // solhint-disable
import "forge-std/console.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract Hello {
    event Receive(address indexed account, uint256 indexed amount);

    receive() external payable {
        emit Receive(msg.sender, msg.value);
    }
}
