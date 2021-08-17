const { expect } = require('chai');
const { ethers } = require('hardhat');

describe('Space Contract', () => {
    let Space, space, owner, addr1;

    beforeEach(async () => {
        Space = await ethers.getContractFactory('SpaceExample');
        space = await Space.deploy();
        [owner, addr1, _] = await ethers.getSigners();
    });

    describe('Create Space', () => {
        it('Should set the correct owner of space', async () => {
            await space.connect(owner).createSpace("My First Space", 2);
            const spaceOwner = await space.getOwner(0);
            //console.log(spaceOwner);
            expect(owner.address).to.equal(spaceOwner.from);
        });
    });
});