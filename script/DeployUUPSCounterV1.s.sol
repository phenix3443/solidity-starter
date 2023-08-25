// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import "forge-std/Script.sol"; // solhint-disable
import {UUPSCounterV1} from "../src/UUPSCounterV1.sol";
import {DeployUUPSScript} from "./DeployUUPSScript.s.sol";

contract DeployUUPSCounterV1 is DeployUUPSScript {
    constructor() DeployUUPSScript(vm.envUint("PRIVATE_KEY")) {}

    //slither-disable-next-line reentrancy-no-eth
    function _run() internal override deploy {
        UUPSCounterV1 c = new UUPSCounterV1();
        implementation = address(c);
        data = bytes.concat(c.initialize.selector);
    }
}
