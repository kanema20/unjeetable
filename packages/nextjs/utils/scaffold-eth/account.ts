import { Address } from "viem";

/* Block, Transaction, TransactionReceipt */
import { Chain } from "wagmi";

export interface PortfolioTableProps {
  //   blocks: Block[];
  accountAddress: Address;
  //   transactionReceipts: TransactionReceipts;
  chainId: Chain["id"];
  isLoading: boolean;
}
