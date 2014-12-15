module Hasql.Prelude
( 
  module Exports,
  bug,
  bottom,
)
where


-- base-prelude
-------------------------
import BasePrelude as Exports

-- transformers
-------------------------
import Control.Monad.Trans.State.Strict as Exports hiding (liftCallCC, liftCatch)
import Control.Monad.Trans.Reader as Exports hiding (liftCallCC, liftCatch)
import Control.Monad.Trans.Class as Exports
import Control.Monad.IO.Class as Exports
import Data.Functor.Identity as Exports

-- mmorph
-------------------------
import Control.Monad.Morph as Exports

-- monad-control
-------------------------
import Control.Monad.Trans.Control as Exports hiding (embed, embed_)

-- transformers-base
-------------------------
import Control.Monad.Base as Exports

-- safe
-------------------------
import Safe as Exports

-- list-t
-------------------------
import ListT as Exports (ListT)

-- vector
-------------------------
import Data.Vector as Exports (Vector)

-- text
-------------------------
import Data.Text as Exports (Text)

-- bytestring
-------------------------
import Data.ByteString as Exports (ByteString)

-- time
-------------------------
import Data.Time as Exports

-- placeholders
-------------------------
import Development.Placeholders as Exports

-- custom
-------------------------
import qualified Debug.Trace.LocationTH


bug = [e| $(Debug.Trace.LocationTH.failure) . (msg <>) |]
  where
    msg = "A \"hasql\" package bug: " :: String

bottom = [e| $bug "Bottom evaluated" |]
