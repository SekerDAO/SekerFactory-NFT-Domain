import { DeployFunction } from "hardhat-deploy/types";
import { HardhatRuntimeEnvironment } from "hardhat/types";
import hre, { deployments, waffle, ethers } from "hardhat";

const deploy: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const { deployments, getNamedAccounts } = hre;
  const { deployer } = await getNamedAccounts();
  const { deploy } = deployments;

  await deploy("SekerFactory", {
    from: deployer,
    args: [],
    log: true,
    deterministicDeployment: true,
    gasPrice: ethers.BigNumber.from("40000000000")
  });
};

deploy.tags = ["seker-factory"];
export default deploy;
