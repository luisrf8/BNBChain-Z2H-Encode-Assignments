// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {
  // Obtenemos el deployer
  const [deployer] = await ethers.getSigners();
  console.log(`Deploying contracts with the account: ${deployer.address}`);

  const balance = await deployer.getBalance();
  console.log(`Account balance: ${balance.toString()}`);

  //Obtenemos el contrato a subir 
  const DummyContract = await hre.ethers.getContractFactory("DummyContract");
  const dummyContract = await DummyContract.deploy();

  console.log("Token deployed to:", dummyContract.address);

  // Deploy por default 
  // const currentTimestampInSeconds = Math.round(Date.now() / 1000);
  // const unlockTime = currentTimestampInSeconds + 60;

  // const lockedAmount = hre.ethers.utils.parseEther("0.001");

  // const Lock = await hre.ethers.getContractFactory("Lock");
  // const lock = await Lock.deploy(unlockTime, { value: lockedAmount });

  // await lock.deployed();

  // console.log(
  //   `Lock with ${ethers.utils.formatEther(
  //     lockedAmount
  //   )}ETH and unlock timestamp ${unlockTime} deployed to ${lock.address}`
  // );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});


// Lesson 9

const DummyContract = await ethers.getContractFactory("DummyContract");
const dummyContract = await DummyContract.deploy();

dummyContract.address

[owner, addr1, addr2, _] = await ethers.getSigners();

const [owner, addr1] = await ethers.getSigners();

await greeter.connect(addr1).setGreeting("Hola!");

const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("DummyContract", function () {
  let DummyContract, dummyContract, owner, addr1, addr2;

  beforeEach(async () => {
    DummyContract = await ethers.getContractFactory("DummyContract");
    dummyContract = await DummyContract.deploy();
    [owner, addr1, addr2] = await ethers.getSigners();
  });

  describe("Deployment", () => {
    it("Should be set with the Dummy Contract information", async () => {
      expect(addr1.address).to.not.equal(await dummyContract.owner());
        //passing tests
        expect(await
          dummyContract.owner()).to.equal(owner.address);
        expect(await
          dummyContract.symbol()).to.equal("DumTkn");
    });
  });

  describe("setUp", () => {
    it("should not allow anyone but the owner to call", async () => {
      await expect(() => dummyContract.connect(addr1).setUp().to.be.revertedWith("Ownable: caller is not the owner"));
    });
  });
  it("Should mint the initial amount to the contract owner", async () => {
    const ownerBalanceBefore = await dummyContract.balanceOf(owner.address);
    await dummyContract.setUp();
    const ownerBalanceAfter = await dummyContract.balanceOf(owner.address);

    expect(ownerBalanceAfter).to.equal(ownerBalanceBefore.add(ownerBalanceBefore + 100));
  });
})