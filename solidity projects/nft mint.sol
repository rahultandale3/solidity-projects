// SPDX-License-Identifier: GPL-3.0 

//https://dev.to/kuvambhardwaj/how-to-mint-nfts-in-solidity-559l refferance
//https://dev.to/kuvambhardwaj/how-to-mint-nfts-in-solidity-559l refferance
//https://dev.to/kuvambhardwaj/how-to-mint-nfts-in-solidity-559l refferance
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract MyToken is ERC721 {
    uint256 public totalMints = 0;

    uint256 public mintPrice = 1 ether;
    uint256 public maxSupply = 50;
    uint256 public maxPerWallet = 5;
    string public URI = "https://bafybeifqmgyfy4by3gpms5sdv3ft3knccmjsqxfqquuxemohtwfm7y7nwa.ipfs.dweb.link/metadata.json";
    mapping(address => uint256) public walletMints;

    constructor() ERC721("MyToken", "MTK") {}

    function safeMint(address to) internal {
        uint256 tokenId = totalMints;
        totalMints++;

        _safeMint(to, tokenId);
    }

    function mintToken(uint256 quantity_) public payable {
        require(quantity_ * mintPrice == msg.value, "wrong amount sent");
        require(walletMints[msg.sender] + quantity_ <= maxPerWallet, "mints per wallet exceeded");

        walletMints[msg.sender] += quantity_;
        safeMint(msg.sender);
    }

    function getMyWalletMints() public view returns (uint256) {
        return walletMints[msg.sender];
    }
}