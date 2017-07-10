# A standard for deposits to exchanges and merchants

This standard if widely adopted will simplify the burden on exchanges and other entities such as merchants which accept deposits and payments on Ethereum. The mechanism through which this happens is by adding a payment reference field to transactions.

### The main goals of developing this standard are:
  1. Reduce burden of parsing the blockchain for all incoming transactions, and the need to issue different addresses for each customer.
  2. Add events to all deposits, and ensure handling is the same when deposits are sent from contracts, including multi-signature wallet contracts.
  3. Ensure wide adoption by wallets and other exchanges for adding a payment reference into a transaction.
  4. Reduce support ticket burden on exchanges and node providers.

### Input is required to ensure wide adoption

  If possible the standard should be expanded to encompass payments and deposits with tokens. In a similar way to the functionality of ENS, a registry contract could allow entities to register their deposit addresses. Any address listed there would then require the end user to add an extra payment reference field in order to send a deposit to that address.

### Current proposal
