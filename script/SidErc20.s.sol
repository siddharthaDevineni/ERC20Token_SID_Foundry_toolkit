// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "lib/forge-std/src/Script.sol";
import {SID} from "src/SID.sol";

contract SidErc20Script is Script {
    function setUp() public {}

    address[] arrayAddr = [
        0xFf58d746A67C2E42bCC07d6B3F58406E8837E883,
        0x30712AFFf57e7BdE6d8480c841DB364640eE3af7,
        0x625BCC1142E97796173104A6e817Ee46C593b3C5,
        0xc013fB828A09CF0b70AcCE2aa896f5Fc53D6AbB2
    ];

    function run() public {
        uint256 key = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(key);

        SID sidERC20 = new SID();
        for (uint256 index = 0; index < arrayAddr.length; index++) {
            sidERC20.transfer(arrayAddr[index], 20e18);
        }
        vm.stopBroadcast();
    }
}
