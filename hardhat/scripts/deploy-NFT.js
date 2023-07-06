const { Contract } = require("ethers");
const hre = require("hardhat");

async function sleep(ms){
    return new Promise((resolve) => setTimeout(resolve, ms))

}

async function main(){
    const nftContract = await 
    hre.ethers.deployContract("CryptoDevs", ["0xe5e0e9427b672e2Ab06c5C436402Ecc0E70729fb", ])

    await nftContract.waitForDeployment();

    console.log("NFT contract Address: ", nftContract.target);

    await sleep(30 * 1000);

    await hre.run("verify:verify", {
        address: nftContract.target,
        constructorArguments: 
        ["0xe5e0e9427b672e2Ab06c5C436402Ecc0E70729fb"],
    });

}

main()
.then(() => process.exit(0))
.catch((error) =>{
    console.error(error);
    process.exit(1)

})
