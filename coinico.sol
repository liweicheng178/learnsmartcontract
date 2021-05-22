// SPDX-License-Identifier: GPL-3.0
//hardcoin ico

//version of complier
pragma solidity >=0.7.0 <0.9.0;

contract hardcoin_ico{
    
    //introducing the max of hardcoin available for sale
    uint public max_hardcoin = 1000000000;
    
    //introduce the usd to hardcoin exchange rate
    uint public usd_to_hardcoin = 1000;
    
    //introducing total number of hardcoin  that have been bought by the invsestors
    uint public total_hardcoin_bought = 0;
    
    //mapping from the investor address to its equity in hardcoin and usd
    mapping(address => uint) equity_hardcoin;
    mapping(address => uint) equity_usd;
    
    //check if an investor can buy hardcoin
    modifier can_buy_hardcoins(uint usd_invested) {
        require (usd_invested * usd_to_hardcoin + total_hardcoin_bought <= max_hardcoin);
        _;
    }
    
    //Getting the equity in hardcoin of an investor
    function equity_in_hardcoins(address investor) external view returns(uint) {
        return equity_hardcoin[investor];
    }
    
    //gettting the equity in usd of an investor
    function equity_in_usd(address investor) external view returns(uint) {
        return equity_usd[investor];
    }
    
    //buy hardcoins
    function buy_hardcoin(address investor, uint usd_invested) external  
    can_buy_hardcoins(usd_invested) {
        uint256 hardcoin_bought = usd_invested * usd_to_hardcoin;
        equity_hardcoin[investor] += hardcoin_bought;
        equity_usd[investor] = equity_hardcoin[investor] / usd_to_hardcoin;
        total_hardcoin_bought += hardcoin_bought;
    }
    
    //sell hardcoins
    function sell_hardcoin(address investor, uint hardcoin_sold) external {
        equity_hardcoin[investor] -= hardcoin_sold;
        equity_usd[investor] = equity_hardcoin[investor] / usd_to_hardcoin;
        total_hardcoin_bought -= hardcoin_sold;
    }
}
