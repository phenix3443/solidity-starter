// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol"; // solhint-disable
import "@openzeppelin/contracts/utils/Strings.sol";

contract Hello {
    struct Person {
        uint8 age;
        string name;
    }
    Person public p;

    constructor(string memory name, uint8 age) {
        p.name = name;
        p.age = age;
    }

    function hello(
        string calldata message
    ) public view returns (string memory) {
        return
            string.concat(
                message,
                " ",
                p.name,
                ", your are",
                Strings.toString(p.age)
            );
    }
}
