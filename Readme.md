[![NPM Package](https://img.shields.io/npm/v/@promos/contracts.svg)](https://www.npmjs.org/package/@promos/contracts)

### Installation

```console
$ npm i @promos/contracts
```

### Usage

Once installed, import and inherit the `Promos` contract

```solidity
pragma solidity ^0.8.0;

import "@promos/contracts/Promos.sol";
import "erc721a/contracts/ERC721A.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ERC721 is ERC721A, Promos, Ownable {
    constructor(address _promosMintContract)
        ERC721A("NAME", "SYMBOL")
        // Provide the latest `promosMintContract` address
        Promos(_promosMintContract)
    {}

    // We need this function for you to able to revoke mint access from Promos
    function setPromosMintContract(address _promosMintContract)
        external
        override
        onlyOwner
    {
        promosMintContract = _promosMintContract;
    }

    // Promos will be using this function to mint. Use `OnlyPromos` modifier to make sure that only Promos can mint via this fucntion. And, finally, Invoke _safeMint(_to, _amount)
    function mintPromos(address _to, uint256 _amount)
        external
        payable
        override
        OnlyPromos(_to)
    {
        _safeMint(_to, _amount);
    }

    // Here we have to override the `supportsInterface` function. It's important to support `IPromos.sol` interface, so we know we deals with compatible contract
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
```
