// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "forge-std/Script.sol"; // solhint-disable
import {CounterV1} from "../../src/transparent/CounterV1.sol";
import {DeployProxy} from "./DeployProxy.s.sol";

contract DeplpyCounterV1 is DeployProxy {
    uint256 private _privateKey = vm.envUint("PRIVATE_KEY");
    address private _address = vm.envAddress("OWNER");

    function run() external deploy(_privateKey, _address) {
        CounterV1 c = new CounterV1();
        implementation = address(c);
        data = bytes.concat(c.initialize.selector);
    }
}
