// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol";

contract Calcium is ERC20 {
    constructor() ERC20("Calcium Max", "XCAL") {
        _mint(msg.sender, 4206900000 * 10 ** decimals());
    }
}