# <img src="logo.png" alt="Promos" height="40px">

[![NPM Package](https://img.shields.io/npm/v/@openzeppelin/contracts.svg)](https://www.npmjs.org/package/@openzeppelin/contracts)

`Promos.sol` - The contract you need to start **minting** directly via [Promos](https://promos.wtf) referral system

## Overview

### Installation

```console
$ npm i @promos/contracts
```

### Usage

Once installed, import and inherit the `Promos` contract

````solidity
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
```# <img src="logo.svg" alt="OpenZeppelin" height="40px">

[![Docs](https://img.shields.io/badge/docs-%F0%9F%93%84-blue)](https://docs.openzeppelin.com/contracts)
[![NPM Package](https://img.shields.io/npm/v/@openzeppelin/contracts.svg)](https://www.npmjs.org/package/@openzeppelin/contracts)
[![Coverage Status](https://codecov.io/gh/OpenZeppelin/openzeppelin-contracts/graph/badge.svg)](https://codecov.io/gh/OpenZeppelin/openzeppelin-contracts)
[![gitpoap badge](https://public-api.gitpoap.io/v1/repo/OpenZeppelin/openzeppelin-contracts/badge)](https://www.gitpoap.io/gh/OpenZeppelin/openzeppelin-contracts)

**A library for secure smart contract development.** Build on a solid foundation of community-vetted code.

 * Implementations of standards like [ERC20](https://docs.openzeppelin.com/contracts/erc20) and [ERC721](https://docs.openzeppelin.com/contracts/erc721).
 * Flexible [role-based permissioning](https://docs.openzeppelin.com/contracts/access-control) scheme.
 * Reusable [Solidity components](https://docs.openzeppelin.com/contracts/utilities) to build custom contracts and complex decentralized systems.

:mage: **Not sure how to get started?** Check out [Contracts Wizard](https://wizard.openzeppelin.com/) — an interactive smart contract generator.

:building_construction: **Want to scale your decentralized application?** Check out [OpenZeppelin Defender](https://openzeppelin.com/defender) — a secure platform for automating and monitoring your operations.

## Overview

### Installation

```console
$ npm install @openzeppelin/contracts
````
