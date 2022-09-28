// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts@4.7.3/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.7.3/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts@4.7.3/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts@4.7.3/access/Ownable.sol";
import "@openzeppelin/contracts@4.7.3/utils/Counters.sol";

contract VirtualNexus is ERC721, ERC721Enumerable, ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    //Contract Address on Rinkeby 0x29F2E69c6118Bda91A0000eBB7b333fF8329cc44

    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("VirtualNexus", "VN") {}

    // Require and reserve tokens for safeMint https://forum.openzeppelin.com/t/best-way-to-limit-mint-to-1-per-wallet-and-reserve-x-token-for-owner/31007

    function safeMint(address to, string memory uri) public onlyOwner {
        require(balanceOf(msg.sender) <= 5, "More than 5 NFTs not supported. Prevents DOS");
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();git 
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}

