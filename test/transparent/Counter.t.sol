// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import "forge-std/Test.sol"; // solhint-disable-line
import {CounterV1} from "../../src/transparent/CounterV1.sol";
import {CounterV2} from "../../src/transparent/CounterV2.sol";
// solhint-disable-next-line
import {ITransparentUpgradeableProxy, TransparentUpgradeableProxy} from "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";

contract CounterTest is Test {
    address public c1;
    address public c2;
    address public proxy;
    address private deployer = vm.envAddress("DEPLOYER");

    function setUp() public {
        CounterV1 c = new CounterV1();
        c1 = address(c);
        bytes memory data = abi.encodeCall(c.initialize, ());
        vm.prank(deployer);
        proxy = address(new TransparentUpgradeableProxy(c1, deployer, data));
    }

    function testIncrNumber() public {
        CounterV1(proxy).incr();
        assertEq(CounterV1(proxy).number(), 1);
    }

    function testSetNumber(uint256 x) public {
        CounterV2 c = new CounterV2();
        c2 = address(c);
        bytes memory data = abi.encodeCall(c.upgradeVersion, ());
        vm.prank(deployer);
        ITransparentUpgradeableProxy(proxy).upgradeToAndCall(c2, data);
        vm.startPrank(address(0));
        assertEq(CounterV2(proxy).version(), "v2");
        CounterV2(proxy).set(x);
        assertEq(CounterV2(proxy).number(), x);
        vm.stopPrank();
    }
}
