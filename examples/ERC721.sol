// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@promos/contracts/Promos.sol";
import "erc721a/contracts/ERC721A.sol";

contract ERC721 is ERC721A, Promos {
    constructor() ERC721A("", "") {}

    /**
     * @dev 
     * After deployment use this function to set `promosProxyContract`. 
     * Mainnet - 0xA7296e3239Db13ACa886Fb130aE5Fe8f5A315721 
     * Goerli  - 0x90766204108309bf97b998E262D05aa1b00Bc35c
     */
    function setPromosProxyContract(address _promosProxyContract)
        external
        override
        onlyOwner
    {
        promosProxyContract = _promosProxyContract;
    }

    function mintPromos(address _to, uint256 _amount)
        external
        payable
        override
        OnlyPromos(_to)
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
}
