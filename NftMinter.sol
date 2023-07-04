// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract MyNFT is ERC721 {
    uint256 internal tokenId;

    constructor() ERC721("MyNFT", "MNFT") {}

    // UNSAFE: anyone can mint, for educational purposes only
    function mint(address to) public {
        unchecked {
            tokenId++;
        }
        _safeMint(to, tokenId);
    }
}

contract Sender {
    function _send() public view returns(bytes memory) {
        return abi.encodeWithSignature("mint(address)", msg.sender);
    }
}

contract Receiver {
    MyNFT nft;

    constructor(address nftAddress) {
        nft = MyNFT(nftAddress);
    }

    function _receive(bytes memory data) public {
        (bool success, ) = address(nft).call(data);
        require(success);
    }
}
