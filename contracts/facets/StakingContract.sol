// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../libraries/LibAppStorage.sol";
import "../interfaces/IERC20.sol";

contract StakingContract {

  LibAppStorage.stakeContract sc;

    event SuccesfulStake(address sender, uint stakeAmount);
    
    event RewardClaimed(address sender, uint claimedAmount, uint stakedAmount);
    
    function stake(uint _amount) external{

        require(msg.sender != address(0), "Address zero detected");
     
        require(_amount > 0, "cannot stake 0 token");

        require(IERC20(sc.stakeToken).balanceOf(msg.sender) > _amount, "Not enough token");
     
        require(IERC20(sc.stakeToken).transferFrom(msg.sender, address(this), _amount), "Failed Deposit");

        sc.amountStaked[msg.sender] = sc.amountStaked[msg.sender] + _amount;
     
        sc.rewardTimeStamp[msg.sender] = block.timestamp;
     
        emit SuccesfulStake(msg.sender, _amount);
    }

     function claimRewardAndStake() external{ 

        require(msg.sender != address(0), "Address zero detected");

        require(sc.amountStaked[msg.sender] !=0, "YOu don't have any stake");
          
        require(block.timestamp >= sc.rewardTimeStamp[msg.sender] + 365 days); 

        sc.rewards[msg.sender] = calculateReward(sc.amountStaked[msg.sender]);

        uint _rewardAmount = sc.rewards[msg.sender];

        uint _stakeAmount = sc.amountStaked[msg.sender];
     
        sc.amountStaked[msg.sender] = 0;

        sc.rewards[msg.sender] = 0;

        IERC20(sc.stakeToken).transfer(msg.sender, _stakeAmount);

        IERC20(sc.rewardToken).transfer(msg.sender, _rewardAmount);

        emit RewardClaimed(msg.sender, _stakeAmount , _rewardAmount);
    }

    function calculateReward(uint256 stakedAmount) internal pure returns (uint256) {
        uint256 rewardAmount = (stakedAmount * 120) / 100;
        return rewardAmount;
    }
}



// TODO 
// 120apy
// Deploy reward token 
// minynjrough interface 
// deploy your diamond 
