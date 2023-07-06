//SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./Whitelist.sol";

contract CryptoDevs is ERC721Enumerable, Ownable{
    uint256 public _price = 0.01 ether;

    uint256 public maxTokenIds = 20;

    Whitelist whitelist;

    uint256 public reserveTokens;
    uint256 public reserveTokensClaimed = 0;

    constructor(address whitelistContract)  ERC721("Crypto Devs", "CD"){
        whitelist = Whitelist(whitelistContract);

        reserveTokens = whitelist.maxWhitelistAddresses();
        }
        function mint() public payable {

            require(totalSupply() + reserveTokens - reserveTokensClaimed 
            < maxTokenIds, "EXCEEED_MAX_SUPPLY"); 

            if(whitelist.whitelistAddresses(msg.sender) && msg.value < _price){

                require(balanceOf(msg.sender) == 0, "ALREADY_OWNED");
                reserveTokensClaimed += 1;
                } else{
                    require (msg.value >= _price, "INSUFFICIENT_ETHER");
                }

                uint256  tokenId = totalSupply();
                _safeMint(msg.sender, tokenId);

            }
            
            function withdraw() public onlyOwner {
                address _owner = owner();
                uint256 amount = address (this).balance;
                (bool sent , ) = _owner.call{value: amount}("");
                require(sent, "Failed to send Ether");
            }
        
}