import { DeployFunction } from "hardhat-deploy/types";
import { HardhatRuntimeEnvironment } from "hardhat/types";

const deploy: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const { deployments, getNamedAccounts } = hre;
  const { deployer } = await getNamedAccounts();
  const { deploy } = deployments;
  const args = [];

  await deploy("SekerFactory", {
    from: deployer,
    args,
    log: true,
    deterministicDeployment: true,
  });
};

deploy.tags = ["seker-factory"];
export default deploy;