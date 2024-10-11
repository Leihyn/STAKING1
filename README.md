# Staking and Token Contracts

This project consists of two main contracts:
- Token Contract: Implements an ERC-20 token with a capped maximum supply.
- Staking Contract: Enables users to stake tokens, withdraw them, and claim rewards based on a fixed reward rate.

Additionally, a **Foundry script** is provided to deploy both the `Token` and `Staking` contracts.

## Features

### Token Contract (`Token.sol`)
- ERC-20 Token: Implements the ERC-20 standard using OpenZeppelin.
- Max Supply: A fixed total supply is minted during contract deployment.
- Minting: The `Token` contract mints the total supply to the owner's address during deployment.

### Staking Contract (`Staking.sol`)
- Stake Tokens: Users can lock their tokens into the contract to earn rewards over time.
- Withdraw Tokens: Users can unlock and withdraw their staked tokens at any time.
- Claim Rewards: Users can claim their earned reward tokens.
- Reward Mechanism: Rewards are distributed at a fixed rate using a custom calculation.

## Contracts Overview

### Token Contract (`Token.sol`)

#### Constructor Parameters:
- `owner_`: Address of the token owner (receives the initial supply).
- `name_`: Name of the token.
- `symbol_`: Symbol of the token.
- `maxSupply_`: Maximum supply of the token (minted during deployment).

#### Events:
- `Mint(address indexed to, uint256 value)`: Emitted when new tokens are minted.

### Staking Contract (`Staking.sol`)

This contract allows users to stake tokens and receive rewards based on their staked amount and the duration of staking.

#### Key Functions:
- `stake(uint256 amount)`: Locks the specified amount of tokens in the contract.
- `withdraw(uint256 amount)`: Unlocks and withdraws the specified amount of staked tokens.
- `claimReward()`: Allows users to claim their earned reward tokens.

#### Reward Calculation:
The reward calculation is based on the following logic:
1. Reward Per Token: A fixed reward rate is applied over time.
2. Earned Rewards: Users earn rewards based on the amount of tokens they have staked and the time they remain staked.

## Deployment Script

The project includes a Foundry script to deploy both the `Token` and `Staking` contracts.

### Staking Script (`Staking.s.sol`)

This script automates the deployment of the `Token` and `Staking` contracts.

#### Steps:
1. Deploys the `Token` contract with an initial supply of `1000 FRk` tokens.
2. Deploys the `Staking` contract and associates it with the `Token` contract.

#### How to Run:
1. Run the script using Foundry's `forge` command:
   ```bash
   forge script path_to/TokenStakingScript.sol --broadcast --private-key <PRIVATE_KEY>
   ```

### Example Script
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {Staking} from "../src/Staking.sol";
import {Token} from "../src/Token.sol";

contract TokenStakingScript is Script {

    Token token;
    Staking staking;

    function run() public {
        vm.broadcast();
        token = new Token(msg.sender, "FARUk", "FRk", 1000000000000000000000);
        staking = new Staking(address(token), address(token));
    }
}
```


## Requirements

- Solidity `^0.8.0`
- OpenZeppelin Contracts (`@openzeppelin/contracts`)
- Foundry for scripting and deployment

## License

This project is licensed under the MIT License.

