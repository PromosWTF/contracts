[![NPM Package](https://img.shields.io/npm/v/@promos/contracts.svg)](https://www.npmjs.org/package/@promos/contracts)

### Installation

```console
$ npm i @promos/contracts
```

### Usage

Once installed, import and inherit the `Promos` contract

**Please, pay particular attention to comments for `mintPromos` function below**

```solidity
pragma solidity ^0.8.0;

import "@promos/contracts/Promos.sol";
import "erc721a/contracts/ERC721A.sol";

contract ERC721 is ERC721A, Promos {
    // IMPORTANT! Only use addresses you see below for Promos constructor
    // Mainnet - 0xA7296e3239Db13ACa886Fb130aE5Fe8f5A315721 
    // Goerli  - 0xf4Ac6561bCE3b841a354ee1eF827A3e48a78F152
    constructor() 
        ERC721A("", "") 
        Promos(1000, 0xf4Ac6561bCE3b841a354ee1eF827A3e48a78F152) {}

    // Promos mint function 
    // IMPORTANT! Must use `MintPromos` modifier
    function mintPromos(address _to, uint256 _amount)
        external
        payable
        override
        MintPromos(_to, _amount)
    {
        // IMPORTANT!
        // Add custom logic here
        // Make sure to implement guardrails like supply, max per wallet, etc.

        // IMPORTANT! 
        // Avoid using msg.sender and use _to argument instead
        _safeMint(_to, _amount);
    }

    // Required to support `IPromos.sol`
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
```
