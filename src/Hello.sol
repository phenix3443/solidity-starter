// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol"; // solhint-disable
import "@openzeppelin/contracts/utils/Strings.sol";

contract Hello {
    mapping(string name => uint256 balance) public balances;

    function set(string calldata name, uint256 _balance) public {
        balances[name] = _balance;
    }
}
