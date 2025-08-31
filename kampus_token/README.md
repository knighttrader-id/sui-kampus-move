# Kampus Token

A Move smart contract for creating and managing a custom token on the Sui blockchain.

## Overview

The Kampus Token project is a Move smart contract that implements a custom fungible token on the Sui blockchain. It follows the Sui token standard and provides functionality for token creation, minting, and burning.

## Project Structure

```
kampus_token/
├── Move.toml          # Project configuration
├── sources/           # Move source files
│   └── kampus_token.move  # Main module
├── tests/             # Test files
│   └── kampus_token_tests.move
└── build/             # Compiled bytecode
    └── kampus_token/
        ├── bytecode_modules/
        └── sources/
```

## Module: `kampus_token`

The main module `kampus_token::kampus_token` provides functionality for managing the KAMPUS token.

### Struct: `KAMPUS_TOKEN`

A one-time witness struct used for initializing the token. This struct ensures that the token can only be initialized once.

### Functions

#### `init`
```move
fun init(witness: KAMPUS_TOKEN, ctx: &mut TxContext)
```

Initializes the token with the following parameters:
- Name: "Kampus Token"
- Symbol: "KAMPUS"
- Decimals: 9
- Description: "Token untuk sistem kampus blockchain"
- Icon URL: "https://kampus.io/icon.png"

This function can only be called once during the initial deployment of the contract.

#### `mint`
```move
public fun mint(
    treasury_cap: &mut TreasuryCap<KAMPUS_TOKEN>,
    amount: u64,
    recipient: address,
    ctx: &mut TxContext
)
```

Mints new tokens and transfers them to the specified recipient.

Parameters:
- `treasury_cap`: The treasury capability that allows minting
- `amount`: The number of tokens to mint
- `recipient`: The address to receive the minted tokens
- `ctx`: The transaction context

#### `burn`
```move
public fun burn(
    treasury_cap: &mut TreasuryCap<KAMPUS_TOKEN>,
    coin: Coin<KAMPUS_TOKEN>
)
```

Burns (destroys) the specified tokens.

Parameters:
- `treasury_cap`: The treasury capability that allows burning
- `coin`: The tokens to burn

## Usage

### Deployment

To deploy the token, the contract must be published with the one-time witness pattern. The `init` function is automatically called during deployment.

### Minting Tokens

Only the owner of the `TreasuryCap` can mint new tokens. This is typically the deployer of the contract.

### Burning Tokens

Only the owner of the `TreasuryCap` can burn tokens.

## Build Instructions

To build the project, ensure you have the Sui CLI installed and run:

```bash
sui move build
```

## Test Instructions

To run tests:

```bash
sui move test
```

Note: The current test suite is minimal and contains placeholder tests due to the complexity of testing blockchain state changes.

## Dependencies

- Sui Framework: Uses the official Sui framework from the Mysten Labs repository

## License

This project is licensed under the MIT License.