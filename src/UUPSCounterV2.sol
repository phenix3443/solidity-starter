// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import {UUPSCounterV1} from "./UUPSCounterV1.sol";

contract UUPSCounterV2 is UUPSCounterV1 {
    function upgradeVersion() public {
        version = "v2";
    }

    function set(uint256 num) public {
        number = num;
    }
}
