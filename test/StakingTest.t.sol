// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {Staking} from "../src/Staking.sol";
import {Token} from "../src/Token.sol";
import {Script} from "forge-std/Script.sol";



contract TokenTest is Test {
    Token public token;
    Staking public staking;
    

    function setUp() external  {
        address owner = address(this);
        
        token = new Token(owner, "FARUk", "FRk", 10000000000000000000000);
 
        staking = new Staking( (address(token)), (address(token)));

        token.approve(address(staking), 10000000000000000000000);


    }

    

    function testInitialMint() public view{
        assertEq(token.totalSupply(), 10000000000000000000000);

        assertEq(token.balanceOf(address(this)), 10000000000000000000000);
        
       // assertEq(token.balanceOf(msg.sender), 10000);

    }

    function testStake() public {
        uint256 s_stakingToken = 10000000000000000000;

        staking.stake(s_stakingToken);

        assertEq(staking.s_balances(address(this)), s_stakingToken);
        
        //console.log(staking.s_balances(address(this)));

    }

    function testWithdraw() public {
        uint256 s_stakingToken = 1000000000000000000000;
        //uint256  REWARD_RATE = 100;

        staking.stake(s_stakingToken);

        vm.warp(block.timestamp + 1 days);

        uint256 expectedRewards = staking.earned(address(this));


        staking.withdraw(s_stakingToken);

        //check user balanace after withdrawal
       // uint256 userBalanceAfterWithdraw = token.balanceOf(address(this));
        uint256 userBalanceAfterWithdraw = staking.s_rewards(address(this)) + s_stakingToken;

        uint256 expectedUserBalanceAfterWithdraw = s_stakingToken + expectedRewards;

        uint256 stakedBalanceAfterWithdraw = staking.s_balances(address(this));


       assertEq(userBalanceAfterWithdraw , expectedUserBalanceAfterWithdraw);

       assertEq(stakedBalanceAfterWithdraw, 0);
       
    }

    function testEarned() public {
        uint256 s_stakingToken = 1000;
        uint256  REWARD_RATE = 100;

        staking.stake(s_stakingToken);

        vm.warp(block.timestamp + 1 days);

        uint256 expectedRewardPerToken = ((REWARD_RATE * 86400) / (s_stakingToken));
        uint256 expectedEarned = (s_stakingToken * expectedRewardPerToken);

        uint256 actualEarned = staking.earned(address(this));

        assertEq(actualEarned, expectedEarned);
    }



    
}
