const { expect } = require('chai');
const { ethers } = require('hardhat');

describe('Token Contract', () => {
    let Token, token, owner, addr1, addr2;

    beforeEach(async () => {
        Token = await ethers.getContractFactory('Token');
        token = await Token.deploy();
        [owner, addr1, addr2, _] = await ethers.getSigners();
    });

    describe('Deployment', () => {
        it('Should set the correct owner', async () => {
            expect(await token.owner()).to.equal(owner.address);
            //console.log("OWNER: %s", owner);
        });
    });

    describe('Minting Tokens', () => {
        it('Should allow owner to mint x amount of tokens', async () => {
            await token.connect(owner).mint(20);
            //console.log("OWNER: %s", owner);
            const balance = await token.balanceOf(owner.address);
            //console.log("BALANCE: %d", balance);
            expect(balance).to.equal(20);
        });
    });

    describe('Sending Tokens', () => {
        it('Should send correct amount of tokens', async () => {
            await token.connect(owner).mint(15);
            await token.connect(owner).send(addr1.address, 10);
            const balance = await token.balanceOf(addr1.address);
            expect(balance).to.equal(10);
        });
    });
});