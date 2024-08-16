// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract Token is ERC20 {
    address public _owner;
    uint256 private _maxSupply;

    event Mint(address indexed to, uint256 value);

    constructor(
        address owner_,
        string memory name_,
        string memory symbol_,
        uint256 maxSupply_
    ) ERC20(name_, symbol_) {
        _mint(owner_, maxSupply_);
    }
}
    