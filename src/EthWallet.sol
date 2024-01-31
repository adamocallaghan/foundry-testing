// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract EthWallet {
    mapping(address user => uint256 collateral) public balances;
    uint256 public numberOfDepositers;

    function depositEthCollateral() public payable {
        require(msg.value > 0, "Eth sent must be greater than zero");
        balances[msg.sender] += msg.value;
        numberOfDepositers += 1;
    }
}
