// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;

import {Script} from "@forge-std/Script.sol";
import {Counter} from "../src/Counter.sol";

contract CounterScript is Script {
    Counter public counter;

    function run() public {
        vm.startBroadcast();

        counter = new Counter();

        vm.stopBroadcast();
    }
}
