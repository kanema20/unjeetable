forge script script/Deploy.s.sol:ERC6551Deploy --rpc-url ${GOERLI_ALCHEMY_RPC_URL} --etherscan-api-key ${ETHERSCAN_API_KEY} --broadcast --verify --optimize --optimizer-runs 20000 -vvvv
forge script script/Interact6551.s.sol:Interact6551 --rpc-url ${GOERLI_ALCHEMY_RPC_URL} --etherscan-api-key ${ETHERSCAN_API_KEY} --broadcast --verify --optimize --optimizer-runs 20000 -vvvv
