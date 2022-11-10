// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@promos/contracts/Promos.sol";
import "erc721a/contracts/ERC721A.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ERC721 is ERC721A, Promos, Ownable {
    constructor() ERC721A("", "") {}

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
