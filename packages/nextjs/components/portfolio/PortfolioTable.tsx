// import { formatEther } from "viem";
// import { TransactionHash } from "~~/components/blockexplorer/TransactionHash";
// import { Address } from "~~/components/scaffold-eth";
// import { getAccount } from '@wagmi/core'
// import { hardhat, mainnet } from "wagmi/chains";
// import { useTokenBalances } from "~~/hooks/scaffold-eth/useTokenBalances";
// import { Alchemy, Network } from "alchemy-sdk";
import * as dotenv from "dotenv";
import { getTargetNetwork } from "~~/utils/scaffold-eth";
//TransactionWithFunction,
import { PortfolioTableProps } from "~~/utils/scaffold-eth/account";

dotenv.config();

export const PortfolioTable = ({ accountAddress, chainId, isLoading }: PortfolioTableProps) => {
  const targetNetwork = getTargetNetwork();
  console.log("accountAddress, chainId: ", accountAddress, chainId);
  return (
    <div className="flex justify-center">
      <table className="table table-zebra w-full shadow-lg">
        <thead>
          <tr>
            <th className="bg-primary">Token</th>
            <th className="bg-primary">Symbol</th>
            <th className="bg-primary">Address</th>
            <th className="bg-primary">Balance</th>
            <th className="bg-primary text-end">Value ({targetNetwork.nativeCurrency.symbol})</th>
            <th className="bg-primary text-end">Value (USD)</th>
          </tr>
        </thead>
        {isLoading ? (
          <tbody>
            {[...Array(20)].map((_, rowIndex) => (
              <tr key={rowIndex} className="bg-base-200 hover:bg-base-300 transition-colors duration-200 h-12">
                {[...Array(7)].map((_, colIndex) => (
                  <td className="w-1/12" key={colIndex}>
                    <div className="h-2 bg-gray-200 rounded-full animate-pulse"></div>
                  </td>
                ))}
              </tr>
            ))}
          </tbody>
        ) : (
          <tbody>
            {/* <tr key={tx.hash} className="hover text-sm">
                    <td className="w-1/12">
                      <TransactionHash hash={tx.hash} />
                    </td>
                    <td className="w-2/12">
                      {tx.functionName === "0x" ? "" : <span className="mr-1">{tx.functionName}</span>}
                      {functionCalled !== "0x" && (
                        <span className="badge badge-primary font-bold text-xs">{functionCalled}</span>
                      )}
                    </td>
                    <td className="w-1/12">{block.number?.toString()}</td>
                    <td className="w-2/12">{timeMined}</td>
                    <td className="w-2/12">
                      <Address address={tx.from} size="sm" />
                    </td>
                    <td className="w-2/12">
                      {!receipt?.contractAddress ? (
                        tx.to && <Address address={tx.to} size="sm" />
                      ) : (
                        <div className="relative">
                          <Address address={receipt.contractAddress} size="sm" />
                          <small className="absolute top-4 left-4">(Contract Creation)</small>
                        </div>
                      )}
                    </td>
                    <td className="text-right">
                      {formatEther(tx.value)} {targetNetwork.nativeCurrency.symbol}
                    </td>
                  </tr> */}
            {/* {blocks.map(block =>
              (block.transactions as TransactionWithFunction[]).map(tx => {
                // const receipt = transactionReceipts[tx.hash];
                const timeMined = new Date(Number(block.timestamp) * 1000).toLocaleString();
                const functionCalled = tx.input.substring(0, 10);

                return (
                  <tr key={tx.hash} className="hover text-sm">
                    <td className="w-1/12">
                      <TransactionHash hash={tx.hash} />
                    </td>
                    <td className="w-2/12">
                      {tx.functionName === "0x" ? "" : <span className="mr-1">{tx.functionName}</span>}
                      {functionCalled !== "0x" && (
                        <span className="badge badge-primary font-bold text-xs">{functionCalled}</span>
                      )}
                    </td>
                    <td className="w-1/12">{block.number?.toString()}</td>
                    <td className="w-2/12">{timeMined}</td>
                    <td className="w-2/12">
                      <Address address={tx.from} size="sm" />
                    </td>
                    <td className="w-2/12">
                      {!receipt?.contractAddress ? (
                        tx.to && <Address address={tx.to} size="sm" />
                      ) : (
                        <div className="relative">
                          <Address address={receipt.contractAddress} size="sm" />
                          <small className="absolute top-4 left-4">(Contract Creation)</small>
                        </div>
                      )}
                    </td>
                    <td className="text-right">
                      {formatEther(tx.value)} {targetNetwork.nativeCurrency.symbol}
                    </td>
                  </tr>
                );
              }),
            )} */}
          </tbody>
        )}
      </table>
    </div>
  );
};
