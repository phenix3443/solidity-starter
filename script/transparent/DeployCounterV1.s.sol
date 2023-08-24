// SPDX-License-Identifier: MIT

pragma solidity ^0.8.21;

import "forge-std/Script.sol"; // solhint-disable
import {CounterV1} from "../../src/transparent/CounterV1.sol";
import {DeployScript} from "./DeployScript.s.sol";

contract DeplpyCounterV1 is DeployScript {
    address private _deployer = vm.envAddress("DEPLOYER");

    constructor() {
        privateKey = vm.envUint("PRIVATE_KEY");
    }

    function _run() internal override deploy(_deployer) {
        CounterV1 c = new CounterV1();
        implementation = address(c);
        data = bytes.concat(c.initialize.selector);
    }
}
