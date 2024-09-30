# Enhanced Clarity Coin Smart Contract

## About

This smart contract implements an enhanced version of the SIP-010 Fungible Token standard in Clarity, the smart contract language for the Stacks blockchain. The contract, named "Enhanced Clarity Coin" (ECC), extends the basic functionality of a fungible token with additional features such as minting, burning, pausing, and blacklisting.

## Features

1. **SIP-010 Compliance**: Implements all standard SIP-010 functions.
2. **Minting**: Allows the contract owner to mint new tokens.
3. **Burning**: Enables token holders to burn their tokens.
4. **Pausing**: The contract owner can pause all token transfers.
5. **Blacklisting**: The contract owner can blacklist specific addresses.
6. **Supply Cap**: Implements a maximum supply limit.

## Token Details

- **Name**: Enhanced Clarity Coin
- **Symbol**: ECC
- **Decimals**: 6
- **Max Supply**: 1,000,000 tokens (1,000,000,000,000 including decimals)
- **Token URI**: https://hiro.so

## Functions

### SIP-010 Standard Functions

1. `get-balance`: Get the token balance of an address.
2. `get-total-supply`: Get the total supply of tokens.
3. `get-name`: Get the name of the token.
4. `get-symbol`: Get the symbol of the token.
5. `get-decimals`: Get the number of decimal places.
6. `get-token-uri`: Get the token URI.

### Enhanced Functions

1. `mint`: Mint new tokens (owner only).
2. `transfer`: Transfer tokens with additional checks.
3. `burn`: Burn tokens.
4. `set-paused`: Pause or unpause all token transfers (owner only).
5. `set-blacklisted`: Blacklist or unblacklist an address (owner only).
6. `is-blacklisted`: Check if an address is blacklisted.
7. `get-paused`: Get the current pause status.
8. `get-total-minted`: Get the total number of minted tokens.

## Error Codes

- `ERR_OWNER_ONLY (u100)`: Operation restricted to contract owner.
- `ERR_NOT_TOKEN_OWNER (u101)`: Sender is not the token owner.
- `ERR_INSUFFICIENT_BALANCE (u102)`: Insufficient balance for the operation.
- `ERR_INVALID_AMOUNT (u103)`: Invalid amount specified.
- `ERR_BLACKLISTED (u104)`: Address is blacklisted.
- `ERR_PAUSED (u105)`: Contract is paused.
- `ERR_CANNOT_BLACKLIST_OWNER (u106)`: Cannot blacklist the contract owner.

## Security Considerations

- Only the contract owner can mint tokens, pause the contract, and manage the blacklist.
- The contract owner cannot be blacklisted.
- Pausing the contract prevents all token transfers.
- Blacklisted addresses cannot send or receive tokens.
- The total supply is capped to prevent inflation.

## About

Chukwudi Daniel Nwaneri