// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import "forge-std/Script.sol"; // solhint-disable-line
import {UUPSCounterV2} from "../src/UUPSCounterV2.sol";
import {DeployUUPSScript} from "./DeployUUPSScript.s.sol";

contract DeployUUPSCounterV2 is DeployUUPSScript {
    constructor() DeployUUPSScript(vm.envUint("PRIVATE_KEY")) {
        proxyAddress = vm.envAddress("PROXY");
    }

    //slither-disable-next-line reentrancy-no-eth
    function _run() internal override upgrade {
        UUPSCounterV2 c = new UUPSCounterV2();
        implementation = address(c);
        data = bytes.concat(c.upgradeVersion.selector);
    }
}
