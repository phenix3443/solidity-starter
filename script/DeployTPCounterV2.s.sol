// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import "forge-std/Script.sol"; // solhint-disable

import {TPCounterV2} from "../src/TPCounterV2.sol";
import {DeployTPScript} from "./DeployTPScript.s.sol";

contract DeployTPCounterV2 is DeployTPScript {
    constructor() DeployTPScript(vm.envUint("PRIVATE_KEY")) {
        proxyAddress = vm.envAddress("PROXY");
    }

    //slither-disable-next-line reentrancy-no-eth
    function _run() internal override upgrade {
        TPCounterV2 c = new TPCounterV2();
        implementation = address(c);
        data = bytes.concat(c.upgradeVersion.selector);
    }
}
