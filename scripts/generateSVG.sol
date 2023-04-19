// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Script.sol";
import "../src/Contract.sol";

interface ERC721tokenURI {
    function tokenURI(uint256 tokenId) external view returns (string memory);
}

contract generateSVG is Script {

    function tokenURI2(uint256 tokenId) public view returns (string memory, INounsSeeder.Seed memory) {
        //TODO: create a function that call the NounsToken 0x9C8fF314C9Bc7F6e59A9d9225Fb22946427eDC03 to obtain the seed generator address
        // and then call the INounsSeeder to obtain the seed
        // and then call the INounsDescriptor to obtain the tokenURI
        //address nounsTokenAddress = 0x9C8fF314C9Bc7F6e59A9d9225Fb22946427eDC03; // Nouns
        address nounsTokenAddress = 0x4b10701Bfd7BFEdc47d50562b76b436fbB5BdB3B; // LilNouns
        INounsToken nounsToken = INounsToken(nounsTokenAddress);
        //INounsSeeder.Seed memory seed = nounsToken.seeder().generateSeed(tokenId, nounsToken.descriptor());
        INounsSeeder.Seed memory seed;
        // Iterate backwards through all the tokens
        for (;tokenId > 0;tokenId--) {
            seed = nounsToken.seeds(tokenId);
            if (seed.background != 0 ||
                seed.body != 0 ||
                seed.accessory != 0 ||
                seed.head != 0 ||
                seed.glasses != 0
                ) break;
        }
        console.log("tokenId:", tokenId);
        uint48 h = uint48(uint256(keccak256(abi.encodePacked(blockhash(block.number - 1), tokenId))));
        uint48 gCount = uint48(nounsToken.descriptor().glassesCount());
        seed.glasses = (seed.glasses+h) % gCount;
        return (nounsToken.descriptor().tokenURI(tokenId, seed), seed);
    }

    function run() external {
        address nounsTokenAddress = 0x4b10701Bfd7BFEdc47d50562b76b436fbB5BdB3B; // LilNouns
        bytes32 CURRENT_INTERNAL_ID_SLOT = bytes32(0x0000000000000000000000000000000000000000000000000000000000000015);
        uint256 currentInternalId = uint256(vm.load(address(nounsTokenAddress), CURRENT_INTERNAL_ID_SLOT));

        console.log("expected internal id", currentInternalId);
        (string memory uriS, INounsSeeder.Seed memory seed) = tokenURI2(currentInternalId);
        
        bytes memory uri = bytes(uriS);
        vm.writeFileBinary("./image.b64uri", uri);
        console.log("image.b64uri length", uri.length);
        console.log("Seed background", seed.background);
        console.log("Seed body", seed.body);
        console.log("Seed accessory", seed.accessory);
        console.log("Seed head", seed.head);
        console.log("Seed glasses", seed.glasses);

    }
}
