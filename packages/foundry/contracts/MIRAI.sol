// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract MIRAI is ERC721, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;

    mapping(address => bool) private _excludedFromFees;

    event ExcludeFromFees(address indexed account);

    constructor() ERC721("MIR.AI", "MIRAI") {}

    function safeMint(address to) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
    }

    function excludeFromFees_(address account_) external onlyOwner {
        _excludedFromFees[account_] = true;
        emit ExcludeFromFees(account_);
    }
}

Struct StakingPool {
    uint8256 poolId;
    string poolName;
    PoolType poolType;
}

enum PoolType {
    ERC20,
    ERC721
}

