// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol"; // solhint-disable
import "@openzeppelin/contracts/utils/Strings.sol";

contract Hello {
    string[] public peoples;

    constructor(string memory name) {
        peoples.push(name);
    }

    function get() public view returns (string[] memory) {
        string[] memory newPeoples = peoples;
        return newPeoples;
    }
}
