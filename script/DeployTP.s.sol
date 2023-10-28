// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import "forge-std/Script.sol"; // solhint-disable-line

// solhint-disable-next-line
import {ITransparentUpgradeableProxy, TransparentUpgradeableProxy} from "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";

import {CounterV1, CounterV2} from "../src/TPCounter.sol";

abstract contract DeployScript is Script {
    uint256 public immutable privateKey;
    address public implementation;
    bytes public data;
    address public proxyAddress;

    error InvalidAddress(string reason);

    modifier create(address deployer) {
        _;
        if (deployer == address(0)) {
            revert InvalidAddress("deployer address can not be zero");
        }
        if (implementation == address(0)) {
            revert InvalidAddress("implementation address can not be zero");
        }
        proxyAddress = address(
            new TransparentUpgradeableProxy(implementation, deployer, data)
        );
    }

    modifier upgrade() {
        _;
        if (proxyAddress == address(0)) {
            revert InvalidAddress("proxy address can not be zero");
        }
        ITransparentUpgradeableProxy proxy = ITransparentUpgradeableProxy(
            proxyAddress
        );
        if (implementation == address(0)) {
            revert InvalidAddress("implementation address can not be zero");
        }
        proxy.upgradeToAndCall(implementation, data);
    }

    constructor(uint256 pkey) {
        privateKey = pkey;
    }

    function run() external {
        vm.startBroadcast(privateKey);
        _run();
        vm.stopBroadcast();
    }

    function _run() internal virtual;
}

contract DeployCounterV1 is DeployScript {
    address private immutable _deployer;

    constructor() DeployScript(vm.envUint("PRIVATE_KEY")) {
        _deployer = vm.envAddress("DEPLOYER");
    }

    //slither-disable-next-line reentrancy-no-eth
    function _run() internal override create(_deployer) {
        CounterV1 c = new CounterV1();
        implementation = address(c);
        data = bytes.concat(c.initialize.selector);
    }
}

contract DeployCounterV2 is DeployScript {
    constructor() DeployScript(vm.envUint("PRIVATE_KEY")) {
        proxyAddress = vm.envAddress("PROXY");
    }

    //slither-disable-next-line reentrancy-no-eth
    function _run() internal override upgrade {
        CounterV2 c = new CounterV2();
        implementation = address(c);
        data = bytes.concat(c.upgradeVersion.selector);
    }
}
