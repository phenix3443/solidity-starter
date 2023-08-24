// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "forge-std/Script.sol"; // solhint-disable

import {CounterV2} from "../../src/transparent/CounterV2.sol";
import {DeployProxy} from "./DeployProxy.s.sol";

contract DeployCounterV2 is DeployProxy {
    uint256 private _privateKey = vm.envUint("PRIVATE_KEY");
    address private _proxyAddress = vm.envAddress("COUNTER_PROXY");

    function run() external upgrade(_privateKey, _proxyAddress) {
        CounterV2 c = new CounterV2();
        implementation = address(c);
        data = bytes.concat(c.upgradeVersion.selector);
    }
}
