// SPDX-License-Identifier: LGPL-3.0-only
pragma solidity ^0.8.6;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract SekerFactory is ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721("Seker Factory", "SEKER") {
    }

    function mint(string memory _tokenURI) public onlyOwner {
        uint256 newNFT = _tokenIds.current();
        _safeMint(msg.sender, newNFT);
        _setTokenURI(newNFT, _tokenURI);
        _tokenIds.increment();
    }
}
