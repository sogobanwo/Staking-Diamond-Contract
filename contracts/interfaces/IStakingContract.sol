// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.9;

interface IStakingContract {

    function stake(uint _amount) external;

    function getTotalStake() external view returns (uint) ;

    function claimRewardAndStake() external;

}