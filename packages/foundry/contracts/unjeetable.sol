//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "lib/openzeppelin-contracts/contracts/proxy/utils/Initializable.sol";

// 

contract Unjeetable is Initializable {
    // globals
    // uint256 public x;
    mapping (address => address) public lockedTokenList;
    mapping (uint256 => (mapping (address => uint256))) public lockedTokenAmounts;
    // TODO: create 2 mappings, one is address -> token -> amount
    // mapping #2: duration of lock for

    // Events
    event Event_LockItUp(address indexed _from, address indexed token_, uint256 amount_, uint256 indexed hoursLocked);

    function initialize() public initializer {
        // x = _x;
    }

    function lockItUpV1(address token_, uint256 amount_, uint256 hoursLocked) payable public {
        // TODO: lock the token for X amount of time (in seconds?)
        require(hoursLocked > 0, "hoursLocked must be greater than 0");
        require(amount_ > 0, "amount_ must be greater than 0");
        require(token_ != address(0), "token_ must not be the zero address");
        // TODO: check if the token is an ERC20 token, allow transfer of tokens to this contract
        // TODO: create entry in mapping

        uint256 unlockTimestamp = block.timeStamp + (hoursLocked * 60 * 60);

        emit Event_LockItUp(msg.sender, token_, amount_, hoursLocked);
        return ;
    }
}