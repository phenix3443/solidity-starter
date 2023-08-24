// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "forge-std/Script.sol"; // solhint-disable
import {CounterV1} from "../../src/uups/CounterV1.sol";
import {DeployScript} from "./DeployScript.s.sol";

contract DeplpyCounterV1 is DeployScript {
    constructor() {
        privateKey = vm.envUint("PRIVATE_KEY");
    }

    function _run() internal override deploy {
        CounterV1 c = new CounterV1();
        implementation = address(c);
        data = bytes.concat(c.initialize.selector);
    }
}