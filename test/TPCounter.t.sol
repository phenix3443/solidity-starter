// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "@forge-std/Test.sol"; // solhint-disable-line
import {TPCounterV1, TPCounterV2} from "../src/TPCounter.sol";
// solhint-disable-next-line
import {ITransparentUpgradeableProxy, TransparentUpgradeableProxy} from "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";

contract TPCounterTest is Test {
    address public c1;
    address public c2;
    address public proxy;
    address public immutable deployer;

    constructor() {
        deployer = vm.envAddress("DEPLOYER");
    }

    //slither-disable-next-line reentrancy-benign
    function setUp() public {
        TPCounterV1 c = new TPCounterV1();
        c1 = address(c);
        bytes memory data = abi.encodeCall(c.initialize, ());
        vm.prank(deployer);
        proxy = address(new TransparentUpgradeableProxy(c1, deployer, data));
    }

    function testIncrNumber() public {
        TPCounterV1(proxy).incr();
        assertEq(TPCounterV1(proxy).number(), 1);
    }

    function testSetNumber(uint256 x) public {
        TPCounterV2 c = new TPCounterV2();
        c2 = address(c);
        bytes memory data = abi.encodeCall(c.upgradeVersion, ());
        vm.prank(deployer);
        ITransparentUpgradeableProxy(proxy).upgradeToAndCall(c2, data);
        vm.startPrank(address(0));
        assertEq(TPCounterV2(proxy).version(), "v2");
        TPCounterV2(proxy).set(x);
        assertEq(TPCounterV2(proxy).number(), x);
        vm.stopPrank();
    }
}
