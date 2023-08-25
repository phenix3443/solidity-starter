// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import "forge-std/Test.sol"; // solhint-disable-line
import {UUPSCounterV1} from "../src/UUPSCounterV1.sol";
import {UUPSCounterV2} from "../src/UUPSCounterV2.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import {UUPSUpgradeable} from "@openzeppelin/contracts/proxy/utils/UUPSUpgradeable.sol";

contract UUPSCounterTest is Test {
    address public c1;
    address public c2;
    address public proxy;

    function setUp() public {
        UUPSCounterV1 c = new UUPSCounterV1();
        c1 = address(c);
        bytes memory data = abi.encodeCall(c.initialize, ());
        proxy = address(new ERC1967Proxy(c1, data));
    }

    function testIncrNumber() public {
        UUPSCounterV1(proxy).incr();
        assertEq(UUPSCounterV1(proxy).number(), 1);
    }

    function testSetNumber(uint256 x) public {
        UUPSCounterV2 c = new UUPSCounterV2();
        c2 = address(c);
        bytes memory data = abi.encodeCall(c.upgradeVersion, ());
        UUPSUpgradeable(proxy).upgradeToAndCall(c2, data);
        assertEq(UUPSCounterV2(proxy).version(), "v2");
        UUPSCounterV2(proxy).set(x);
        assertEq(UUPSCounterV2(proxy).number(), x);
    }
}
