// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;


interface INounsDescriptorMinimal {
    ///
    /// USED BY TOKEN
    ///

    function tokenURI(uint256 tokenId, INounsSeeder.Seed memory seed) external view returns (string memory);

    function dataURI(uint256 tokenId, INounsSeeder.Seed memory seed) external view returns (string memory);

    ///
    /// USED BY SEEDER
    ///

    function backgroundCount() external view returns (uint256);

    function bodyCount() external view returns (uint256);

    function accessoryCount() external view returns (uint256);

    function headCount() external view returns (uint256);

    function glassesCount() external view returns (uint256);
}

interface INounsSeeder {
    struct Seed {
        uint48 background;
        uint48 body;
        uint48 accessory;
        uint48 head;
        uint48 glasses;
    }

    function generateSeed(uint256 nounId, INounsDescriptorMinimal descriptor) external view returns (Seed memory);
}


interface INounsDescriptor {
    event PartsLocked();

    event DataURIToggled(bool enabled);

    event BaseURIUpdated(string baseURI);

    function arePartsLocked() external returns (bool);

    function isDataURIEnabled() external returns (bool);

    function baseURI() external returns (string memory);

    function palettes(uint8 paletteIndex, uint256 colorIndex) external view returns (string memory);

    function backgrounds(uint256 index) external view returns (string memory);

    function bodies(uint256 index) external view returns (bytes memory);

    function accessories(uint256 index) external view returns (bytes memory);

    function heads(uint256 index) external view returns (bytes memory);

    function glasses(uint256 index) external view returns (bytes memory);

    function backgroundCount() external view returns (uint256);

    function bodyCount() external view returns (uint256);

    function accessoryCount() external view returns (uint256);

    function headCount() external view returns (uint256);

    function glassesCount() external view returns (uint256);

    function addManyColorsToPalette(uint8 paletteIndex, string[] calldata newColors) external;

    function addManyBackgrounds(string[] calldata backgrounds) external;

    function addManyBodies(bytes[] calldata bodies) external;

    function addManyAccessories(bytes[] calldata accessories) external;

    function addManyHeads(bytes[] calldata heads) external;

    function addManyGlasses(bytes[] calldata glasses) external;

    function addColorToPalette(uint8 paletteIndex, string calldata color) external;

    function addBackground(string calldata background) external;

    function addBody(bytes calldata body) external;

    function addAccessory(bytes calldata accessory) external;

    function addHead(bytes calldata head) external;

    function addGlasses(bytes calldata glasses) external;

    function lockParts() external;

    function toggleDataURIEnabled() external;

    function setBaseURI(string calldata baseURI) external;

    function tokenURI(uint256 tokenId, INounsSeeder.Seed memory seed) external view returns (string memory);

    function dataURI(uint256 tokenId, INounsSeeder.Seed memory seed) external view returns (string memory);

    function genericDataURI(
        string calldata name,
        string calldata description,
        INounsSeeder.Seed memory seed
    ) external view returns (string memory);

    function generateSVGImage(INounsSeeder.Seed memory seed) external view returns (string memory);
}

interface INounsToken {
    event NounCreated(uint256 indexed tokenId, INounsSeeder.Seed seed);

    event NounBurned(uint256 indexed tokenId);

    event NoundersDAOUpdated(address noundersDAO);

    event MinterUpdated(address minter);

    event MinterLocked();

    event DescriptorUpdated(INounsDescriptor descriptor);

    event DescriptorLocked();

    event SeederUpdated(INounsSeeder seeder);

    event SeederLocked();

    function mint() external returns (uint256);
    function minter() external returns (address);
    function totalSupply() external view returns (uint256);

    function burn(uint256 tokenId) external;

    function dataURI(uint256 tokenId) external returns (string memory);

    function setNoundersDAO(address noundersDAO) external;

    function setMinter(address minter) external;

    function lockMinter() external;

    function setDescriptor(INounsDescriptor descriptor) external;

    function lockDescriptor() external;

    function setSeeder(INounsSeeder seeder) external;

    function lockSeeder() external;
    function seeder() external view returns (INounsSeeder);
    function descriptor() external view returns (INounsDescriptorMinimal);
    function seeds(uint256 tokenId) external view returns (INounsSeeder.Seed memory);
}

contract Contract {

    function tokenURI(uint256 tokenId) external view returns (string memory) {
        //TODO: create a function that call the NounsToken 0x9C8fF314C9Bc7F6e59A9d9225Fb22946427eDC03 to obtain the seed generator address
        // and then call the INounsSeeder to obtain the seed
        // and then call the INounsDescriptor to obtain the tokenURI
        // and then call the INounsDescriptor to obtain the dataURI
        // and then call the INounsDescriptor to obtain the genericDataURI
        // and then call the INounsDescriptor to obtain the generateSVGImage
        address nounsTokenAddress = 0x9C8fF314C9Bc7F6e59A9d9225Fb22946427eDC03;
        INounsToken nounsToken = INounsToken(nounsTokenAddress);
        //INounsSeeder.Seed memory seed = nounsToken.seeder().generateSeed(tokenId, nounsToken.descriptor());
        INounsSeeder.Seed memory seed = nounsToken.seeds(tokenId);
        seed.glasses = seed.glasses+1;
        return nounsToken.descriptor().tokenURI(tokenId, seed);
    }

    function tokenURI2(uint256 tokenId) external view returns (string memory, INounsSeeder.Seed memory) {
        //TODO: create a function that call the NounsToken 0x9C8fF314C9Bc7F6e59A9d9225Fb22946427eDC03 to obtain the seed generator address
        // and then call the INounsSeeder to obtain the seed
        // and then call the INounsDescriptor to obtain the tokenURI
        // and then call the INounsDescriptor to obtain the dataURI
        // and then call the INounsDescriptor to obtain the genericDataURI
        // and then call the INounsDescriptor to obtain the generateSVGImage
        address nounsTokenAddress = 0x9C8fF314C9Bc7F6e59A9d9225Fb22946427eDC03;
        INounsToken nounsToken = INounsToken(nounsTokenAddress);
        //INounsSeeder.Seed memory seed = nounsToken.seeder().generateSeed(tokenId, nounsToken.descriptor());
        INounsSeeder.Seed memory seed = nounsToken.seeds(tokenId);
        seed.glasses = seed.glasses+1;
        return (nounsToken.descriptor().tokenURI(tokenId, seed), seed);
    }
}
