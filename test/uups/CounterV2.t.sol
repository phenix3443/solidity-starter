// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "forge-std/Test.sol"; // solhint-disable-line
import {CounterV2} from "../../src/uups/CounterV2.sol";

contract CounterTest is Test {
    CounterV2 public counter;

    function setUp() public {
        counter = new CounterV2();
        counter.set(0);
    }

    function testIncrNumber() public {
        counter.incr();
        assertEq(counter.number(), 1);
    }

    function testSetNumber(uint256 x) public {
        counter.set(x);
        assertEq(counter.number(), x);
    }
}
