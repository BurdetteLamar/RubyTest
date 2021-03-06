require 'contracts'

include Contracts

# Custom contract type for verdict id.
VERDICT_ID = Or[Symbol, Array]
# Custom contract type for verdict message.
VERDICT_MESSAGE = Maybe[Or[Symbol, String]]
# Custom contract type for verdict volatility.
VERDICT_VOLATILE = Maybe[Bool]
# Custom contract type for put_element args.
ARGS = Args[Any]
