module Main where

import Main.Prelude
import Criterion.Main
import qualified Hasql.Connection as HC
import qualified Hasql.Query as HQ
import qualified Hasql.Encoders as HE
import qualified Hasql.Decoders as HD
import qualified Hasql.Session
import qualified Main.Queries as Q


main =
  HC.acquire settings >>= either (fail . show) use
  where
    settings =
      HC.settings host port user password database
      where
        host = "localhost"
        port = 5432
        user = "postgres"
        password = ""
        database = "postgres"
    use connection =
      defaultMain
      [
        bgroup "decoding"
        [
          bgroup "1 column"
          [
            bench "1 row" $ nfIO $! query () $! Q.select1 1
            ,
            bench "100 rows" $ nfIO $! query () $! Q.select1 100
            ,
            bench "10000 rows" $ nfIO $! query () $! Q.select1 10000
          ]
          ,
          bgroup "4 columns"
          [
            bench "1 row" $ nfIO $! query () $! Q.select4 1
            ,
            bench "100 rows" $ nfIO $! query () $! Q.select4 100
            ,
            bench "10000 rows" $ nfIO $! query () $! Q.select4 10000
          ]
        ]
      ]
      where
        query :: a -> HQ.Query a b -> IO b
        query params query =
          {-# SCC "query" #-} 
          (=<<) (either (fail . show) pure) $
          flip Hasql.Session.run connection $ Hasql.Session.query params query
