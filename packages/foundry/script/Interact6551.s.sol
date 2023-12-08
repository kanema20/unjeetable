//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "../contracts/MIRAI.sol";
import "../contracts/ERC6551Registry.sol";
import "./DeployHelpers.s.sol";

contract Interact6551 is ScaffoldETHDeploy {
    error InvalidPrivateKey(string);
    address _registryAddress = 0x000000006551c19487814612e58FE06813775758;
    address _implementation = 0x41C8f39463A868d3A88af00cd0fe7102F30E44eC;
    uint256 _goerliChainId = 5;
    ERC6551Registry _mirai6551;
    MIRAI _miraiToken;
    uint256 _tokenId = 0;
    bytes32 _salt = 0;
    address _miraiTokenAddress = 0x7182D4Ff67eFA6d19FBcE022d4453B09c0036204;
    address _tokenBoundAccountAddress = 0xCe443E71285FE00C661Ec9Ad4CBb39d91D8e04AE;

    function run() external {
        uint256 deployerPrivateKey = setupLocalhostEnv();
        if (deployerPrivateKey == 0) {
            revert InvalidPrivateKey(
                "You don't have a deployer account. Make sure you have set DEPLOYER_PRIVATE_KEY in .env or use `yarn generate` to generate a new random account"
            );
        }
        vm.startBroadcast(deployerPrivateKey);

        sendFundsToTokenAccount();
        _transferToken(_tokenBoundAccountAddress);

        vm.stopBroadcast();

        /**
         * This function generates the file containing the contracts Abi definitions.
         * These definitions are used to derive the types needed in the custom scaffold-eth hooks, for example.
         * This function should be called last.
         */
        exportDeployments();
    }

    function getTokenBoundAccount(address _miraiTokenAddress) public returns (address) {
        _mirai6551 = ERC6551Registry(_registryAddress);
        return _mirai6551.account(_implementation, _salt, _goerliChainId, _miraiTokenAddress, _tokenId);
    }

    function sendFundsToTokenAccount() internal {
        address _tokenAccount = getTokenBoundAccount(_miraiTokenAddress);
        console.logString(
            string.concat(
                "NFTBotAccount deployed at: ",
                vm.toString(_tokenAccount)
            )
        );

        uint256 balanceBefore = address(_miraiTokenAddress).balance;
        console.logString(string.concat("Balance Before: ", vm.toString(balanceBefore)));

        (bool sent, bytes memory data) = payable(_tokenBoundAccountAddress).call{value: 0.01 ether}("");
        // payable(_miraiTokenAddress).send(0.01 ether);
        require(sent, "Failed to send Ether");

        uint256 balanceAfter = address(_tokenBoundAccountAddress).balance;
        console.logUint(balanceAfter);
        console.logString(string.concat("Sent: ", vm.toString(balanceAfter), " ether"));
    }

    function _transferToken(address _newOwner) internal {
        _miraiToken = MIRAI(_miraiTokenAddress);
        address currentOwner = _miraiToken.ownerOf(_tokenId);
        console.logString(string.concat("Token Bound Account Owner: ", vm.toString(address(currentOwner))));
        
        //FIX: 
        // approval
        _miraiToken.approve(_tokenBoundAccountAddress, _tokenId);

        _miraiToken.transferFrom(vm.envAddress("DEPLOYER_PUBLIC_KEY"), _newOwner, 0);
        
        address newOwner = _miraiToken.ownerOf(_tokenId);
        console.logString(string.concat("New Owner of Token ", vm.toString(_tokenId), ": ", vm.toString(newOwner)));
    }


    function test() public {}
}
