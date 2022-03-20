import { expect } from "chai";
import hre, { deployments, waffle, ethers } from "hardhat";
import "@nomiclabs/hardhat-ethers";

const ZeroState =
  "0x0000000000000000000000000000000000000000000000000000000000000000";
const ZeroAddress = "0x0000000000000000000000000000000000000000";
const FirstAddress = "0x0000000000000000000000000000000000000001";

describe("SekerFactorNFT", async () => {
  const baseSetup = deployments.createFixture(async () => {
    await deployments.fixture();

    const SekerFactory = await hre.ethers.getContractFactory("SekerFactory");
    const sekerFactory = await SekerFactory.deploy();

    return { SekerFactory, sekerFactory };
  });

  const [user1, user2] = waffle.provider.getWallets();

  describe("initialize", async () => {
    it("should initialize NFT contract", async () => {
      const { sekerFactory } = await baseSetup();
      const minter = await sekerFactory.isMinter(user1.address);
      console.log(minter)
      await sekerFactory.mint("https://gateway.pinata.cloud/ipfs/QmXcztC1qwqNiUe4vHRNJioDGGxUsVYLjcXb8c9GJZSo6h")
      const uri = await sekerFactory.tokenURI(0);
      console.log(uri);
      await sekerFactory.addMinter(user2.address);
      const minter2 = await sekerFactory.isMinter(user2.address);
      console.log(minter2)
    });
  });
});
