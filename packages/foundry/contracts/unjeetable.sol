//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "lib/openzeppelin-contracts/contracts/proxy/utils/Initializable.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import "lib/openzeppelin-contracts/contracts/access/Ownable.sol";
import "lib/openzeppelin-contracts/contracts/security/ReentrancyGuard.sol";

contract Unjeetable is Initializable, ReentrancyGuard, Ownable {
    // globals

    /*
    User -> Token -> Amount
    User -> Token2 -> Amount
    */    

    address public admin;
    address[] public approvedTokens;
    mapping (address => uint256) public lockedTokens; // locked amount of each token
    mapping (address => mapping (address => uint256)) public userLockedTokenAmounts; // user -> token addr -> amount
    mapping (address => mapping (address => uint256)) public userLockedTokenUnlockTimestamps; // user -> token addr -> unlock timestamp ??
    // Events
    event Event_LockItUp(address indexed _from, address indexed token_, uint256 amount_, uint256 indexed hoursLocked);
    event AddTokenToApprovedList(address indexed token_);
    event Even_YouCanJeetNow(address indexed token_, uint256 indexed amount_);

    // function initialize(address admin_) public initializer { // for eip-2535
    //     admin = admin_;
    // }

    // OR
    
    constructor(address admin_) {
        admin = admin_;
    }
    // follow uncx univ2 lock structure
    function lockItUpV1(address token_, uint256 amount_, uint256 hoursLocked) payable public {
        // TODO: lock the token for X amount of time (in seconds?)
        require(hoursLocked > 0, "hoursLocked must be greater than 0");
        require(amount_ > 0, "amount_ must be greater than 0");
        require(token_ != address(0), "token_ must not be the zero address");
        // TODO: check if the token is an ERC20 token, allow transfer of tokens to this contract
        require(checkIfTokenInList(token_) == true, "token not supported");

        // TODO: create entry in mapping (user address => token => amount => length locked)

        uint256 unlockTimestamp = block.timestamp + (hoursLocked * 60 * 60);
        userLockedTokenUnlockTimestamps[msg.sender][token_] = unlockTimestamp;
        userLockedTokenAmounts[msg.sender][token_] = amount_;
        transferERC20(token_, amount_, address(this));
        lockedTokens[token_] += amount_;

        emit Event_LockItUp(msg.sender, token_, amount_, hoursLocked);
        return ;
    }

    function youCanJeetNow(address token_) payable external {
        // TODO: send tokens back to user
        require(token_ != address(0), "token_ must not be the zero address");
        require(userLockedTokenUnlockTimestamps[msg.sender][token_] > 0, "user has no tokens locked");
        require(block.timestamp >= userLockedTokenUnlockTimestamps[msg.sender][token_], "tokens are still locked");
        
        uint256 amount_ = userLockedTokenAmounts[msg.sender][token_];
        IERC20(address(token_)).safeTransferFrom(destVault, address(msg.sender), _amount);
        lockedTokens[token_] -= amount_;
        userLockedTokenAmounts[msg.sender][token_] = 0;

        emit Event_YouCanJeetNow(token_, amount_);
    }

    function lockAdditional() external payable {
        // TODO: need to update the structure for locked token amounts with timestampes for each account
    }

    function transferERC20(address token_, address destVault, uint256 amount) public {
        require(amount > 0, "amount must be greater than 0");
        IERC20(address(token_)).safeTransferFrom(address(msg.sender), destVault, _amount);
    }

    function checkIfTokenInList(address token_) public returns (bool) {
        // loop through all `store` items until the item with the corresponding ID is found
        for (uint8 i = 0; i < approvedTokens.length; i++) {
                // check if token is in list
            if (approvedTokens[i] == token_) {
                return true;
           } else {
                return false;
           }
        }
    }

    function emergencyWithdraw(uint256 amount_) public {
        // 10% penalty for withdrawing early
        require(amount_ > , "amount must be greater than locked amount");

    }   

    function addTokenToApprovedList(address token_) internal onlyOwner() {
        require(token_ != address(0), "token_ must not be the zero address");
        approvedTokens.push(token_);
        emit AddTokenToApprovedList(token_);
    }

        /**
     * Function that allows the contract to receive ETH
     */
    receive() external payable {}
}