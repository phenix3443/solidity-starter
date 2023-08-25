// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import "forge-std/Script.sol"; // solhint-disable
import {TPCounterV1} from "../src/TPCounterV1.sol";
import {DeployTPScript} from "./DeployTPScript.s.sol";

contract DeployTPCounterV1 is DeployTPScript {
    address private immutable _deployer;

    constructor() DeployTPScript(vm.envUint("PRIVATE_KEY")) {
        _deployer = vm.envAddress("DEPLOYER");
    }

    function _run() internal override deploy(_deployer) {
        TPCounterV1 c = new TPCounterV1();
        implementation = address(c);
        data = bytes.concat(c.initialize.selector);
    }
}
