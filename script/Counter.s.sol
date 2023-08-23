// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "forge-std/Script.sol"; // solhint-disable-line

contract CounterScript is Script {
    function setUp() public {} // solhint-disable-line

    function run() public {
        vm.broadcast();
    }
}
