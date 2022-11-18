// SPDX-License-Identifier: MIT
// Promos v1.0.0
// Creator: promos.wtf

pragma solidity ^0.8.0;

import "./IPromos.sol";
import "./PromosProxy.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/introspection/ERC165.sol";

abstract contract Promos is IPromos, ERC165, Ownable {
    address public promosProxyContract;
    uint256 public promosSupply;

    constructor(uint256 _promosSupply) {
        promosSupply = _promosSupply;
    }

    modifier MintPromos(address _to, uint256 _mintAmount) {
        address promosMintContract = PromosProxy(promosProxyContract)
            .promosMintAddress();
        require(_to != promosMintContract, "Not ERC721 reciever");
        require(msg.sender == promosMintContract, "Wrong msg.sender");
        require(_mintAmount <= promosSupply, "Exceeds Promos supply");
        promosSupply = promosSupply - _mintAmount;
        _;
    }

    function setPromosSupply(uint256 _promosSupply) external onlyOwner {
        promosSupply = _promosSupply;
    }

    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(ERC165)
        returns (bool)
    {
        return
            interfaceId == type(IPromos).interfaceId ||
            super.supportsInterface(interfaceId);
    }

    receive() external payable {}
}
