//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "lib/openzeppelin-contracts/contracts/proxy/utils/Initializable.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import "lib/openzeppelin-contracts/contracts/";

// 

contract Unjeetable is Initializable {
    // globals
    // uint256 public x;
    address public admin;
    address[] public approvedTokens;
    mapping (address => address) public userLockedTokenList;
    mapping (uint256 => mapping (address => uint256)) public lockedTokenAmounts;
    // TODO: create 2 mappings, one is address -> token -> amount
    // mapping #2: duration of lock for

    // Events
    event Event_LockItUp(address indexed _from, address indexed token_, uint256 amount_, uint256 indexed hoursLocked);

    function initialize(address admin_) public initializer {
        admin = admin_;
    }

    function lockItUpV1(address token_, uint256 amount_, uint256 hoursLocked) payable public {
        // TODO: lock the token for X amount of time (in seconds?)
        require(hoursLocked > 0, "hoursLocked must be greater than 0");
        require(amount_ > 0, "amount_ must be greater than 0");
        require(token_ != address(0), "token_ must not be the zero address");
        // TODO: check if the token is an ERC20 token, allow transfer of tokens to this contract
        
        // TODO: create entry in mapping (address => token => amount)

        uint256 unlockTimestamp = block.timeStamp + (hoursLocked * 60 * 60);

        emit Event_LockItUp(msg.sender, token_, amount_, hoursLocked);
        return ;
    }

    function transferERC20(address token_, ) public {

    }

    function checkIfTokenInList(address token_) internal {
        // loop through all `store` items until the item with the corresponding ID is found
        for (uint i; i < .length; i++) {
            if (store[i].id == id) {
                // corresponding item found - update quantity and early return
                store[i].quantity += quantity;
                return;
            }
        }
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can call this function");
    }

    function addTokenToApprovedList(address token_) internal onlyAdmin() {

    }

        /**
     * Function that allows the contract to receive ETH
     */
    receive() external payable {}
}