// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@promos/contracts/Promos.sol";
import "erc721a/contracts/ERC721A.sol";

contract ERC721 is ERC721A, Promos {
    // Specify Promos max supply and contract: promosProxyContractMainnet or promosProxyContractTestnet
    constructor()
        ERC721A("", "")
        Promos(500, 0xf4Ac6561bCE3b841a354ee1eF827A3e48a78F152)
    {}

    // Promos mint function
    // IMPORTANT! Must use `MintPromos` modifier
    function mintPromos(address _to, uint256 _amount)
        external
        payable
        override
        MintPromos(_to, _amount)
    {
        // IMPORTANT!
        // Custom logic here
        // Make sure to implement guardrails like supply, max per wallet, etc.

        // IMPORTANT!
        // Avoid using msg.sender and use _to argument instead
        _safeMint(_to, _amount);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(ERC721A, Promos)
        returns (bool)
    {
        return
            Promos.supportsInterface(interfaceId) ||
            super.supportsInterface(interfaceId);
    }

    // IMPORTANT! Implement this function in order
    // to receive funds from Promos to your contract
    receive() external payable override {}
}
