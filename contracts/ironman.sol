// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract Ironman2022 is ERC721, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    uint256 MAX_SUPPLY = 30;
    string baseURI = "ipfs://QmWTKTSJHhGxShgQdjWwQGYaCGK3B4K4Ug1pWbYCsey4rW/";
    string baseExtension = ".json";

    mapping (address => bool) public mintedWallets;

    constructor() ERC721("Ironman2022", "IM2022") {}

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(
            _exists(tokenId),
            "ERC721Metadata: URI query for nonexistent token"
        );
        return string(abi.encodePacked(baseURI, Strings.toString(tokenId), baseExtension));
    }

    function safeMint() public {
        uint256 tokenId = _tokenIdCounter.current();
        require (tokenId < MAX_SUPPLY, "Sorry, This NFT collection has been fully minted.");
        require (mintedWallets[msg.sender] == false, "Sorry, You can only mint this NFT one per wallet.");
        _tokenIdCounter.increment();
        mintedWallets[msg.sender] = true;
        _safeMint(msg.sender, tokenId);
    }
}
