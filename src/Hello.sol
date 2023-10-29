// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "forge-std/Script.sol"; // solhint-disable

contract Hello {
    string public name;

    constructor(string memory _name) {
        name = _name;
    }

    function hello(
        string calldata message
    ) public view returns (string memory) {
        return string.concat(message, "", name);
    }
}
