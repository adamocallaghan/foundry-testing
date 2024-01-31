// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {EthWallet} from "../src/EthWallet.sol";

contract EthWalletTest is Test {
    EthWallet public wallet;

    // variables
    uint256 public oneEth = 1e18;

    // create a user address
    address public bob = makeAddr("bob");

    function setUp() public {
        wallet = new EthWallet(); // create contract instance

        vm.deal(bob, 10000e18); // give bob 10,000 ETH
    }

    function test_depositCollateral_ExpectRevert_NoEtherSent() public {
        vm.startPrank(bob);
        vm.expectRevert("Eth sent must be greater than zero");
        wallet.depositEthCollateral{value: 0 ether}();
        vm.stopPrank();
    }

    function test_depositCollateral_UserBalanceShouldUpdate() public {
        _depositOneEthAsBob();

        uint256 bobBalance = wallet.balances(bob);
        assertEq(bobBalance, oneEth);
    }

    function test_depositCollateral_NumberOfDepositersShouldUpdate() public {
        _depositOneEthAsBob();

        uint256 numberOfDepositers = wallet.numberOfDepositers();
        assertEq(numberOfDepositers, 1);
    }

    // =============
    // == HELPERS ==
    // =============

    function _depositOneEthAsBob() public {
        vm.startPrank(bob);
        wallet.depositEthCollateral{value: 1 ether}();
        vm.stopPrank();
    }
}
