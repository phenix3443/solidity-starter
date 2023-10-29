// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol"; // solhint-disable-line

import {Hello} from "../src/Hello.sol";

contract DeployHello is Script {
    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        new Hello();
        vm.stopBroadcast();
    }
}
