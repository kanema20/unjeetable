//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "lib/openzeppelin-contracts/contracts/proxy/utils/Initializable.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import "lib/openzeppelin-contracts/contracts/access/Ownable.sol";
import "lib/openzeppelin-contracts/contracts/security/ReentrancyGuard.sol";

contract MiraiAccount {
    enum Archetype {
        NPC, CHAD, NORMIE, DEGEN
        }

    address public owner;
    string public name;
    Archetype public archetype;
    
    constructor(address _owner, string memory _name, Archetype memory _archetype) payable {
        owner = _owner;
        name = _name;
        archetype = _archetype;
        miraiAddr = address(this);
    }
}


contract MiraiFactory {
    MiraiAccount[] public miraiAccounts;
    function createMirai(address _owner, string memory _name, Archetype memory _archetype) public returns (address) {
        MiraiAccount newMiraiAccount = new MiraiAccount(_owner, _name, _archetype);
        miraiAccounts.push(newMiraiAccount);        
        return address(newMirai);
    }

    function getMiraiAccounts() public returns (MiraiAccount[]) {
        return miraiAccounts;
    }

    function createAccountAndSendEth(address _owner, string memory _name, Archetype memory _archetype) public payable returns (address) {
        MiraiAccount newMiraiAccount = (new MiraiAccount){value: msg.value}(_owner, _name, _archetype);
        miraiAccounts.push(newMiraiAccount);
        return address(newMiraiAccount); 
    }

}