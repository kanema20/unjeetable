import { useEffect } from "react";
// import { PortfolioTable } from "~~/components/portfolio/PortfolioTable";
import { getAccount } from "@wagmi/core";
import type { NextPage } from "next";
// mainnet
import { useBalance } from "wagmi";
import { hardhat } from "wagmi/chains";
import { PaginationButton } from "~~/components/blockexplorer/PaginationButton";
import { SearchBar } from "~~/components/blockexplorer/SearchBar";
import { useFetchBlocks } from "~~/hooks/scaffold-eth";
import { getTargetNetwork, notification } from "~~/utils/scaffold-eth";

// import { useTokenBalances } from "~~/hooks/scaffold-eth/useTokenBalances";

const PortfolioTracker: NextPage = () => {
  const { currentPage, totalBlocks, setCurrentPage, error } = useFetchBlocks(); // blocks, transactionReceipts,
  // const mainnetChainId = mainnet.id;
  const account = getAccount();
  const anonBalance = useBalance({
    address: account.address,
    token: "0x7199B5A15c7Fb79AA861780230ADc65fff99eC73",
  });

  console.log(anonBalance.data);

  // const balances  = useTokenBalances(account.address);
  // console.log(balances)

  useEffect(() => {
    if (getTargetNetwork().id === hardhat.id && error) {
      notification.error(
        <>
          <p className="font-bold mt-0 mb-1">Cannot connect to local provider</p>
          <p className="m-0">
            - Did you forget to run <code className="italic bg-base-300 text-base font-bold">yarn chain</code> ?
          </p>
          <p className="mt-1 break-normal">
            - Or you can change <code className="italic bg-base-300 text-base font-bold">targetNetwork</code> in{" "}
            <code className="italic bg-base-300 text-base font-bold">scaffold.config.ts</code>
          </p>
        </>,
      );
    }

    if (getTargetNetwork().id !== hardhat.id) {
      notification.error(
        <>
          <p className="font-bold mt-0 mb-1">
            <code className="italic bg-base-300 text-base font-bold"> targeNetwork </code> is not localhost
          </p>
          <p className="m-0">
            - You are on <code className="italic bg-base-300 text-base font-bold">{getTargetNetwork().name}</code> .This
            block explorer is only for <code className="italic bg-base-300 text-base font-bold">localhost</code>.
          </p>
          <p className="mt-1 break-normal">
            - You can use{" "}
            <a className="text-accent" href={getTargetNetwork().blockExplorers?.default.url}>
              {getTargetNetwork().blockExplorers?.default.name}
            </a>{" "}
            instead
          </p>
        </>,
      );
    }
  }, [error]);

  return (
    <div className="container mx-auto my-10">
      <div>
        <p>Portfolio Tracker for: {account.address}</p>
      </div>
      <SearchBar />
      {/* <PortfolioTable accountAddress={account.address} chainId={mainnetChainId} isLoading={isLoading} /> */}
      <PaginationButton currentPage={currentPage} totalItems={Number(totalBlocks)} setCurrentPage={setCurrentPage} />
    </div>
  );
};

export default PortfolioTracker;
