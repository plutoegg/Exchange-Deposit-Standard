// This contract is to replace the need for sweeping wallets to hot wallet
// User cannot just send funds on their own but will need to call a function with a reference number

Contract hotWallet{

event DepositMade(string _refId, uint _amount);
event Withdrawal(address _to, uint _amount);
uint hotWalletBalance; // (in Wei)
uint exchangeOwner;

modifier onlyOwner {
  if (msg.sender != exchangeOwner) { throw;
  _;
}

function () {
// Explicitly not payable, so user funds sent back if no reference provided
}

function hotWallet () payable {
  hotWalletBalance = msg.value; // Set up wallet with an initial balance for withdrawals
  exchangeOwner = msg.sender;
}

function deposit (string reference) payable {
  value = msg.value;
  hotWalletBalance += value;
  DepositMade(reference, value); // Exchange sets up watcher for this Event
}

function withdraw (uint amount, address to) onlyOwner {
  // Perform checks on amount

  // Send the funds to address specified

  Withdrawal(to, amount);
}


}
