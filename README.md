# Foundry template

This is a template for a Foundry project.

## Installation

To install with [DappTools](https://github.com/dapphub/dapptools):

```
dapp install [user]/[repo]
```

To install with [Foundry](https://github.com/gakonst/foundry):

```
forge install [user]/[repo]
```

## Local development

This project uses [Foundry](https://github.com/gakonst/foundry) as the development framework.

### Dependencies

```
make update
```

### Compilation

```
make build
```

### Testing

```
make test
```

### Generate SVG files

```
forge "script" --fork-url "https://eth-mainnet.g.alchemy.com/v2/${YOUR_API_KEY}" scripts/generateSVG.sol && cat image.b64uri | cut -d, -f2 | base64 -d -i | jq -r .image | cut -d, -f2 | base64 -d -i > image.svg
```