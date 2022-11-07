// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@promos/contracts/Promos.sol";
import "erc721a/contracts/ERC721A.sol";

contract ERC721 is ERC721A, Promos {
    constructor(address _promosMintContract)
        ERC721A("NAME", "SYMBOL")
        Promos(_promosMintContract)
    {}

    function setPromosMintContract(address _promosMintContract)
        external
        override
    {
        promosMintContract = _promosMintContract;
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
