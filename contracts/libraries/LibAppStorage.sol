// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

library LibAppStorage {
	
	struct stakeToken{

		mapping(address => uint256) balances;

    mapping(address => mapping(address => uint256)) allowances;

    uint256  totalSupply;

    string  name;

    string  symbol;
    
		uint8   decimal;

    address owner;

	}

  struct stakeContract {
    address rewardToken;

    address stakeToken;
    
    // MAPPINGS
    mapping (address => uint) amountStaked;
            
    mapping (address => uint) rewardTimeStamp;

    mapping(address => uint256) rewards;

  }

}