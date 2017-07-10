# A standard for deposits to exchanges and merchants

This standard if widely adopted will simplify the burden on exchanges and other entities such as merchants, who accept large numbers of deposits and payments on Ethereum. The solution being proposed is a deposit contract to be widely used, which requires the addition of a payment reference field to transactions.

### The main goals of developing this standard are:
  1. Reduce burden of parsing the blockchain for all incoming transactions, and the need to issue different addresses for each customer.
  2. Ensure events are issued for all deposits, and ensure handling is the same whether deposits are sent from other contracts, including multi-signature wallet contracts, or from regular addresses.
  3. Ensure wide adoption by wallets and other exchanges for adding a payment reference into a transaction.
  4. Reduce support ticket burden on exchanges and node providers.
  5. To enable batch payments of transactions sent via a contract, without causing issues for exchanges. It is currently not easy be able to detect these incoming deposits from contracts.

### Further input is required to ensure wide adoption

  If possible the standard should be expanded to encompass payments and deposits with tokens.

  In a similar way to the functionality of ENS, a registry contract could allow entities to register their deposit addresses. Wallet applications would ensure that for any address listed in that registry contract the end user would be asked to add an extra payment reference field in order to send a deposit to that address.

### Basic deposit contract

  A first deposit contract is proposed with the following features:
  1. Deposits are received via the `sendDeposit(uint256 paymentReference) payable` function.
  1. Only deposits with a valid supplied uint payment reference are accepted, and issue a `DepositReceived` event.
  2. All other deposits, either calling the function without a valid payment reference or via the fallback function, return the sent ether to the sender, and issue a `BadDepositReceived` event.
  3. The contract also includes a `claimTokens` function allowing any ERC20 tokens sent to the contract to be retrieved by the owner and manually returned to the sender. It would be preferable to extend the contract to accept deposits of tokens, using for example the ERC223 standard proposed.

  The ideal usage would be for client wallets to offer a paymentReference field and allow a user to input it if the deposit contract is found in a registry.

  A second more basic usage is possible now without relying on wide scale adoption, since most wallets allow user to add a `data` field already to their transactions when sending ether to an address.
  1. Provide a 'payment reference' for users to copy and paste into the data field. This would be for example: `0x3958fe9e0000000000000000000000000000000000000000000000000000000000340769` , where the `0x3958fe9e` represents the sendDeposit function for the contract, and `340769` is the hex payment reference.
  2. User sends the amount of ETH they wish to deposit to the deposit address, adding the data.
