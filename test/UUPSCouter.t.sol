// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "forge-std/Test.sol"; // solhint-disable-line
import {CounterV1, CounterV2} from "../src/UUPSCounter.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import {UUPSUpgradeable} from "@openzeppelin/contracts/proxy/utils/UUPSUpgradeable.sol";

contract UUPSCounterTest is Test {
    address public c1;
    address public c2;
    address public proxy;

    function setUp() public {
        CounterV1 c = new CounterV1();
        c1 = address(c);
        bytes memory data = abi.encodeCall(c.initialize, ());
        proxy = address(new ERC1967Proxy(c1, data));
    }

    function testIncrNumber() public {
        CounterV1(proxy).incr();
        assertEq(CounterV1(proxy).number(), 1);
    }

    function testSetNumber(uint256 x) public {
        CounterV2 c = new CounterV2();
        c2 = address(c);
        bytes memory data = abi.encodeCall(c.upgradeVersion, ());
        UUPSUpgradeable(proxy).upgradeToAndCall(c2, data);
        assertEq(CounterV2(proxy).version(), "v2");
        CounterV2(proxy).set(x);
        assertEq(CounterV2(proxy).number(), x);
    }
}
