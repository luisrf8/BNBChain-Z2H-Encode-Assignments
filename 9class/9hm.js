import { useState } from "react";
import { ethers } from "ethers";
 
function App() {
  let [queriedAccount, setQueriedAccount] = useState("");
  let [name, setName] = useState("");
  let [symbol, setSymbol] = useState("");
  let [account, setAccount] = useState("");
  let [connected, setConnected] = useState(false);
  let [myBalance, setMyBalance] = useState("");
  let [balanceOf, setBalanceOf] = useState("");
  let [transferAccount, setTransferAccount] = useState("");
  let [transferAmount, setTransferAmount] = useState("");
 
  let { ethereum } = window;
  let contract
 
  if (ethereum) {
 
    const abi = [
      // Read-Only Functions
      "function balanceOf(address owner) view returns (uint)",
      "function decimals() view returns (uint8)",
      "function name() view returns (string)",
      "function symbol() view returns (string)",
      // Authenticated Functions
      "function transfer(address to, uint amount) returns (bool)",
       // Events
      "event Transfer(address indexed from, address indexed to, uint amount)"
    ];
    let address = "0x9660477E202a489ecf8cA2c49a88b4198caDFAC3";
    let provider = new ethers.providers.Web3Provider(ethereum);
    let signer = provider.getSigner();
    contract = new ethers.Contract(address, abi, signer);
  }

  let connectedActions = async () => {
      setName(await contract.name())
      setSymbol(await contract.symbol())
  }
 
  return (
    <div className="App">
      <h1>Name: {name}</h1>
      <h1>Symbol: ${symbol}</h1>
 
      <button onClick={() => {
          if (contract && !connected) {
              ethereum.request({ method: 'eth_requestAccounts'})
                  .then(accounts => {
                      setAccount(accounts[0])
                      setConnected(true);
                      connectedActions();
                  })
          }
      }}>{!connected ? 'Connect wallet' : 'Connected' }</button>

      <form onSubmit={(e) => {
        e.preventDefault();
        if (contract && connected) {
          contract.transfer(transferAccount, ethers.utils.parseEther(transferAmount))
        }
      }}>
          <input type="submit" value="Transfer:" />
          <input type="text" placeholder="amount" onChange={e => setTransferAmount(e.currentTarget.value)} value={transferAmount} />
          &nbsp;to&nbsp;
          <input type="text" placeholder="account" onChange={e => setTransferAccount(e.currentTarget.value)} value={transferAccount} />
      </form>

 
      <form onSubmit={(e) => {
        e.preventDefault();
        if (contract && connected) {
          contract.balanceOf(queriedAccount)
            .then(balance => {
               setBalanceOf(ethers.utils.formatUnits(balance));
            })
        }
      }}>
          <input type="submit" value="Get balance of:" />
          <input type="text" placeholder="account" onChange={e => setQueriedAccount(e.currentTarget.value)} value={queriedAccount} />
      </form>

      <h3>Balance is: {balanceOf}</h3>

      <button onClick={() => {
        if (contract && connected) {
          contract.balanceOf(account)
            .then(balance => {
               setMyBalance(ethers.utils.formatUnits(balance));
            })
        }
      }}>Get my balance</button>

      <h3>My balance: {myBalance}</h3>
    </div>
  );
}
 
export default App;