// stake: Lock tokens into our smart contract
// withdraw: unlock tokens and pull out of the contract
// claimReward: users get their reward tokens
// Figure out a good reward mechanism and good reward math?


// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

error Staking__TransferFailed();
error Staking__NeedsMoreThanZero();

contract Staking {
    //ierc20 is used because it doesnt have approve function unlike erc20 which its approve function contents migght contradict our address content(so we can call the function in erc20 and that of our address)
    IERC20 public s_stakingToken;
    IERC20 public s_rewardToken;

    //someone address to how much they staked
    mapping(address => uint256) public s_balances;

    //how much each address has been paid  
    mapping(address => uint256) public s_userRewardPerTokenPaid;
    // how much rewards each address has to claim
    mapping(address => uint256) public s_rewards;

    uint256 public constant REWARD_RATE = 100;
    uint256 public s_totalSupply;
    uint256 public s_rewardPerTokenStored;
    uint256 public s_lastUpdateTime;

    modifier updateReward(address account) {
        // how much reward per token?
        // last timestamp
        // user earned X tokens
        // the math varies from each protocol; this one is used by SYNTHRX
        
        s_rewardPerTokenStored = rewardPerToken();
        s_lastUpdateTime = block.timestamp;
        s_rewards[account] = earned(account);
        s_userRewardPerTokenPaid[account] = s_rewardPerTokenStored;
        _;
    }

    modifier moreThanZero(uint256 amount) {
        if(amount == 0) {
            revert Staking__NeedsMoreThanZero();
        }
        _;
    }

    constructor(address stakingToken, address rewardToken) {
        s_stakingToken = IERC20(stakingToken);
        s_rewardToken = IERC20(rewardToken);
    }

    function earned(address account) public view returns(uint256) {
        uint256 currentBalance = s_balances[account];
        // how much they have been paid already
        uint256 amountPaid = s_userRewardPerTokenPaid[account];
        uint256 currentRewardPerToken = rewardPerToken();
        uint256 pastRewards = s_rewards[account];
        uint256 _earned = ((currentBalance * (currentRewardPerToken - amountPaid)) / 1e18) + pastRewards;

        return _earned;
    }
    
    // Based on how long since the most recent snapshot
    function rewardPerToken() public view returns(uint256) {
        if (s_totalSupply == 0) {
            return s_rewardPerTokenStored;
        }
        return s_rewardPerTokenStored + 
        (((block.timestamp - s_lastUpdateTime) * REWARD_RATE * 1e18) / s_totalSupply);
    }
    // do we allow any tokens? - not allow any token.
    // if we were to allow any tokens; would need chainlink/oracle to convert  prices btw tokens
    // or just a specific token?...using this 

    function stake(uint256 amount) external updateReward(msg.sender) moreThanZero(amount) { 
        // This contract doesnt call approval, the user would on the UI(on the token contract)
        // this contract doesnt own the tokens; so cant call approve
        // keep track of how much the user has stked
        // keep track of how much token we have in  total
        // transfer the tokens to this contract

        s_balances[msg.sender] += amount;
        s_totalSupply += amount;
        //emit event
        bool success = s_stakingToken.transferFrom(msg.sender, address(this), amount);
        //require(success, "Failed"); costs a lot of gas
        if(!success) {
            revert Staking__TransferFailed(); //uses less gas
        }
    }

    function withdraw(uint256 amount) external updateReward(msg.sender) moreThanZero(amount) {
        s_balances[msg.sender] -= amount;
        s_totalSupply -= amount;
        bool success = s_stakingToken.transfer(msg.sender, amount);
        //bool success = s_stakingToken.transferFrom(address(this), msg.sender, amount);
        if(!success) {
            revert Staking__TransferFailed(); //uses less gas
        }
    }

    function claimReward() external updateReward(msg.sender) {

        uint256 reward = s_rewards[msg.sender];

        bool success = s_rewardToken.transfer(msg.sender, reward);
        if(!success) {
            revert Staking__TransferFailed(); //uses less gas
        }
        // how much reward do they get?
        //the contract is going to emit X tokens per second
        // and dsiperse them to all token stakers

        //constants reward rate is essential in order not to bankruot the protocol

    }
}