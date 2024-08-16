

# DeFi Staking App - Foundry Project

## Overview
Welcome to the DeFi Staking App project! This project is built using Solidity and Foundry and allows users to stake tokens and earn rewards. The project was inspired by the ["Code along with Chainlink Labs Lead Developer Advocate Patrick Collins and build your very own DeFi staking app"](https://www.youtube.com/live/-48_hdo9_gg?si=A8Su5Iy6jqbHdliw) tutorial.

## Features
- Staking: Users can stake their tokens into the contract.
- Rewards: Users earn rewards over time based on the amount they have staked.
- Withdrawal: Users can unstake their tokens and withdraw their rewards.


## Project Structure
```
├── src
│   └── Staking.sol            # Main staking contract
├── test
│   └── Staking.t.sol          # Test cases for the staking contract
├── foundry.toml               # Foundry configuration file
├── README.md                  # Project documentation
```

## Getting Started

### Prerequisites
Before you begin, ensure you have the following installed on your machine:
- Node.js (v14 or higher)
- Foundry (Solidity development environment)
- Git (for version control)

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/defi-staking-app.git
   cd defi-staking-app
   ```

2. Install Foundry:
   Follow the instructions on the [Foundry website](https://book.getfoundry.sh) to install Foundry if you haven't already.

3. Install dependencies:
   ```bash
   forge install
   ```

4. Compile the contracts:
   ```bash
   forge build
   ```

5. Deploy the contract:
   Deploy the contract to a local network or a testnet (e.g., Sepolia).
   ```bash
   forge create --rpc-url https://sepolia.infura.io/v3/YOUR_INFURA_PROJECT_ID --private-key YOUR_PRIVATE_KEY src/Staking.sol:Staking
   ```

6. Run tests:
   ```bash
   forge test
   ```

## Usage
Once deployed, the staking contract allows users to:
- Stake tokens by calling the `stake()` function.
- Claim rewards periodically using the `claimReward()` function.
- Unstake tokens and withdraw their staked amount and rewards with the `withdrawal()` function.

### Example:
```solidity
contract Staking {
    // Staking contract code
}
```

## Inspiration
This project was heavily inspired by the ["Code along with Chainlink X Patrick Collins"](https://www.youtube.com/live/-48_hdo9_gg?si=A8Su5Iy6jqbHdliw) tutorial. Special thanks to Patrick Collins and the Chainlink team for providing such valuable educational content!

## Contributing
Contributions are welcome! Please feel free to submit a pull request or open an issue if you find any bugs or have suggestions for improvements.
