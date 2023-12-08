// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../contracts/MIRAI.sol";

contract YourContractTest is Test {
    MIRAI public mirai;

    function setUp() public {
        mirai = new MIRAI();
    }

    // function testMessageOnDeployment() public view {
    //     require(
    //         keccak256(bytes(mirai.greeting())) ==
    //             keccak256("Building Unstoppable Apps!!!")
    //     );
    // }

    function testSafeMint() public {
        mirai.safeMint(vm.addr(1));
        // mirai.setGreeting("Learn Scaffold-ETH 2! :)");
        // require(
        //     keccak256(bytes(mirai.greeting())) ==
        //         keccak256("Learn Scaffold-ETH 2! :)")
        // );
    }
}
