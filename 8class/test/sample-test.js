import "hardhat/console.sol"; // Importamos la libreria de consola
const { expect } = require('chai');
const {ethers} = require('hardhat');

describe('DummyContract', function () {

    let DummyContract, dummyContract, owner, addr1, addr2;

    beforeEach(async function () {
        DummyContract = await ethers.getContractFactory('DummyContract');
        dummyContract = await DummyContract.deploy();
        [owner, addr1, addr2, _] = await ethers.getSigners();
    });

    describe('Deployment', () => {
        it('Should be set with the Dummy Contract information', async () => {
            expect(addr1.address).to.not.equal(await dummyContract.owner());
            expect(await dummyContract.owner()).to.equal(owner.address);     
            expect(await dummyContract.name()).to.equal('DummyToken');
            expect(await dummyContract.symbol()).to.equal('DumTkn');
        });
    })
});

    describe("setUp", () => {
        it("should no allow anyone but the owner to set up the contract", async () => {
            await expect(() => 
                dummyContract
                    .setUp({ from: addr1})
                    .to.be.revertedWith("Ownable: caller is not the owner")
            );
        });
        it("should mint the initial amount to the contract owner", async () => {
            const ownerBalanceBefore = await dummyContract.balanceOf(owner.address);
            await dummyContract.setUp();
            const ownerBalanceAfter = await dummyContract.balanceOf(owner.address);
            expect(ownerBalanceAfter).to.equal(ownerBalanceBefore +100);
        })
    })
    