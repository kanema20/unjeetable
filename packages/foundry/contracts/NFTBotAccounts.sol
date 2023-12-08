//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "lib/openzeppelin-contracts/contracts/proxy/utils/Initializable.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import "lib/openzeppelin-contracts/contracts/access/Ownable.sol";
import "lib/openzeppelin-contracts/contracts/security/ReentrancyGuard.sol";

contract NFTTradingBotWallet {
// Create trading bot accounts as NFTs, each with their own wallet, using the ERC-6551 standard
    uint public num;
    address public sender;
    uint public value;
    

    constructor() {
            
    }

    function setVars(uint _nums) public payable {
        num = _nums;
        sender = msg.sender;
        value = msg.value;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "only admin");
        _;
    }

    // call another contract to do X, can only be called by admin
    function callAnotherContract(address _contract, uint _num) payable onlyAdmin() {
        (bool success, bytes memory data) = _contract.delegatecall(
            abi.encodeWithSignature("setVars(uint256)", _num)
        ); 
    }


    receive() payable external {}   
}

contract delegateA {
    uint public num;
    address public sender;
    uint public value;

    function setVars(address _contract, uint _num) public payable {
        (bool success, bytes memory data) = _contract.delegatecall(
            abi.encodeWithSignature("setVars(uint256)", _num)
        ); 
    }
}
