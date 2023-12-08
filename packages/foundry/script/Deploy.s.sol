//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "../contracts/MIRAI.sol";
import "../contracts/ERC6551Registry.sol";
import "./DeployHelpers.s.sol";

contract ERC6551Deploy is ScaffoldETHDeploy {
    error InvalidPrivateKey(string);
    address registryAddress = 0x000000006551c19487814612e58FE06813775758;
    address implementation = 0x41C8f39463A868d3A88af00cd0fe7102F30E44eC;
    uint256 goerliChainId = 5;
    ERC6551Registry mirai6551;
    function run() external {
        uint256 deployerPrivateKey = setupLocalhostEnv();
        if (deployerPrivateKey == 0) {
            revert InvalidPrivateKey(
                "You don't have a deployer account. Make sure you have set DEPLOYER_PRIVATE_KEY in .env or use `yarn generate` to generate a new random account"
            );
        }
        vm.startBroadcast(deployerPrivateKey);

        mirai6551 = ERC6551Registry(registryAddress);

        MIRAI mirai = new MIRAI();

        mirai.safeMint(vm.envAddress("DEPLOYER_PUBLIC_KEY"));
        console.logString(
            string.concat(
                "NFTBotAccount deployed at: ",
                vm.toString(address(mirai))
            )
        );

        mirai6551.createAccount(implementation, 0, goerliChainId, address(mirai), 0);

        vm.stopBroadcast();

        /**
         * This function generates the file containing the contracts Abi definitions.
         * These definitions are used to derive the types needed in the custom scaffold-eth hooks, for example.
         * This function should be called last.
         */
        exportDeployments();
    }

    function test() public {}
}
