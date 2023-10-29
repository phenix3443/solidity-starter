// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol"; // solhint-disable
import "@openzeppelin/contracts/utils/Strings.sol";

contract Hello {
    struct Person {
        string name;
        uint256 age;
    }

    Person[] public peoples;

    constructor(string memory name, uint256 age) {
        Person memory p = Person(name, age);
        peoples.push(p);
    }

    function get() public view returns (Person[] memory) {
        Person[] memory newPeoples = peoples;
        return newPeoples;
    }
}
