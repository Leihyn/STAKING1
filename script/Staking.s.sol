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
        staking = Staking(address(token));
    }
}