//SPDX-License-Identifier: MIT
pragma solidity ^0.8;


contract Whitelist{

    uint8 public maxWhitelistAddresses;

    mapping (address => bool) public whitelistAddresses;

    uint8 public numOfWhitelistedAddressses;

    constructor (uint8 _maxwhitelistedAddresses){
        maxWhitelistAddresses = _maxwhitelistedAddresses ; }

    function addAddressToWhitelist() public {
            require(!whitelistAddresses[msg.sender], "Sender is already on the whitelist");

            require (numOfWhitelistedAddressses < maxWhitelistAddresses, "More addresses can't be added, limit reached");
            
            whitelistAddresses[msg.sender] = true;

            numOfWhitelistedAddressses += 1;

        }


    
}