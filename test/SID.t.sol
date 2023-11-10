// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13;

import {Test, console2, StdStyle, StdCheats} from "lib/forge-std/src/Test.sol";
import {SID} from "../src/SID.sol";

contract BaseSetup is Test, SID {
    address internal alice;
    address internal bob;

    constructor() SID() {}

    function setUp() public virtual {
        alice = makeAddr("alice");
        bob = makeAddr("bob");

        console2.log(StdStyle.magenta("Mint 100 tokens to Alice"));
        deal(address(this), alice, 100e18);
        console2.log("balanceOf(alice): ", balanceOf(alice));
    }
}

contract TransferTokenTest is BaseSetup {
    function testTransferTokenCorrectly() public {
        vm.prank(alice);
        bool success = this.transfer(bob, 10e18); // Alice transfers to Bob

        assertTrue(success);

        assertEq(balanceOf(alice), 90e18); // leftover balance of Alice
        assertEq(balanceOf(bob), 9.9e18); // new balance of Bob

        assertEq(this.contractBalance(), 0.1e18); // 1% transfer fee to the token contract
    }

    function testRevertOnNotEnoughBalance() public {
        vm.prank(alice);
        vm.expectRevert("ERC20: transfer amount exceeds balance");
        this.transfer(bob, 120e18); // Alice transfers to Bob
    }
}

contract TokenDepositTest is BaseSetup {
    function testDepositTokenCorrectly() public {
        vm.prank(alice);
        this.deposit(50e18);

        assertEq(balanceOf(alice), 150e18); // total balance of Alice after deposit
    }
}
