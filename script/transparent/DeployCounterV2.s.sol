// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import "forge-std/Script.sol"; // solhint-disable

import {CounterV2} from "../../src/transparent/CounterV2.sol";
import {DeployScript} from "./DeployScript.s.sol";

contract DeployCounterV2 is DeployScript {
    constructor() {
        privateKey = vm.envUint("PRIVATE_KEY");
        proxyAddress = vm.envAddress("PROXY");
    }

    function _run() internal override upgrade {
        CounterV2 c = new CounterV2();
        implementation = address(c);
        data = bytes.concat(c.upgradeVersion.selector);
    }
}
